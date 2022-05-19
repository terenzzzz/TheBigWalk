class Spreadsheet
    require 'bundler'
    require 'csv'    
    Bundler.require
    #https://www.rubydoc.info/gems/google_drive/1.0.5/GoogleDrive
    session = GoogleDrive::Session.from_service_account_key("client_secret.json")

    @@spreadsheet = session.spreadsheet_by_title("softwarehut exported data")
    @@walker_title_columns = 4
    #first worksheet
    #worksheet = @@spreadsheet.worksheets.first

    #pull data
    #worksheet.rows.first(10).each { |row| puts row.first(6).reverse.join(" | ") }

    #get worksheet by title
    #@@spreadsheet.worksheet_by_title("Sheet1")

    #add worksheet
    #@@spreadsheet.add_worksheet("bob", max_rows = 100, max_cols = 20)

    #insert row
    #worksheet.insert_rows(worksheet.num_rows + 1, [["This", "was", "added", "From", "code"], ["This", "was", "added", "From", "code"]])
    #worksheet.save

    #update cell
    #worksheet["A1"] = "bob"
    #worksheet.save

    #delete 14th and 15 rows
    #worksheet.delete_rows(14, 2)
    #worksheet.save

    #what if multiple people update the table at once will it mess it up is there a que
    def add_route(name)
        #check if route already exists but what if they make duplicate events??
        existing_worksheet = @@spreadsheet.worksheet_by_title(name)
        if !(existing_worksheet)
            @@spreadsheet.add_worksheet(name, max_rows = 100, max_cols = 20)
            worksheet = @@spreadsheet.worksheet_by_title(name)
            worksheet["A1"] = "Walker Name"
            worksheet["B1"] = "Walker ID"
            worksheet["C1"] = "Walker droped out / pickups"
            worksheet["D1"] = "Walker pickup location"
            #if anymore are added increase
            worksheet.save
        end
    end

    def update_route(old_name, new_name)
        #breaks if thers no worksheet by the name
        existing_worksheet = @@spreadsheet.worksheet_by_title(new_name)
        if !(existing_worksheet)
            worksheet = @@spreadsheet.worksheet_by_title(old_name)
            if worksheet
                worksheet.title = new_name
                worksheet.save
            end
        else
            delete_route(old_name)
        end
    end

    def delete_route(name)
        #breaks if thers no worksheet by the name
        worksheet = @@spreadsheet.worksheet_by_title(name)
        if worksheet
            worksheet.delete
        end
    end

    def update_event(old_name, event)
        #breaks if thers no worksheet by the name
        routes = Route.where(event_id: event.id)
        routes.each do |route|
            worksheet = @@spreadsheet.worksheet_by_title("#{old_name} - #{route.name}")
            if worksheet
                worksheet.title = "#{event.name} - #{route.name}"
                worksheet.save
            end
        end
    end

    def delete_event(event)
        #breaks if thers no worksheet by the name
        routes = Route.where(event_id: event.id)
        routes.each do |route|
            worksheet = @@spreadsheet.worksheet_by_title("#{event.name} - #{route.name}")
            if worksheet
                worksheet.delete
            end
        end
    end

    def update_checkpoint_name(route, checkpoint)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        if worksheet
            col_num = RoutesAndCheckpointsLinker.where(route_id: route.id, checkpoint_id: checkpoint.id).first.position_in_route + @@walker_title_columns
            worksheet[1,col_num] = checkpoint.name
            worksheet.save
        end
    end

    #needs to happen after linker has updated
    #should it just pass linker??
    def update_checkpoint_position(route, checkpoint, old_pos)
        #if old pos == new pos return
        new_pos = RoutesAndCheckpointsLinker.where(route_id: route.id, checkpoint_id: checkpoint.id).first.position_in_route
        if old_pos == new_pos
            return
        end

        #figures out where where to add the new checkpoint and delete old
        if new_pos > old_pos
            add_checkpoint(route, checkpoint, (new_pos+1), 1)
            delete_checkpoint(route, checkpoint.name, old_pos)
        else
            add_checkpoint(route, checkpoint, new_pos, 1)
            delete_checkpoint(route, checkpoint.name, (old_pos+1))
        end
    end

    #really it deletes a column
    def delete_checkpoint(route, checkpoint, pos)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}") 
        if worksheet
            col_num = pos + @@walker_title_columns
            
            #double checks if the chosen cell has the same name - dont know if nessassery
            if worksheet[1,col_num] != checkpoint
                return
            end
            
            if col_num > worksheet.max_cols
                raise(ArgumentError, 'The col number is out of range')
            end
            #moves all of the column to the right left
            for c in col_num..(worksheet.max_cols - 1)
                for r in 1..(worksheet.num_rows)
                    worksheet[r, c] = worksheet.input_value(r, c + 1)
                end
            end
            worksheet.max_cols -= 1

            worksheet.save
        end
    end
    
    #really it inserts a column
    #should it just pass linker instead of route and checkpoint??
    def add_checkpoint(route, checkpoint, pos, update_checkpoint)
        #make sure when handling checkpoint position + 2 for walker titles or more
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}") 
        if worksheet
            #TODO is this really needed cus of validation
            #checks if the checkpoint is already in the spreadsheeta and returns if it is
            if update_checkpoint == 0
                routes_linkers = RoutesAndCheckpointsLinker.where(route_id: route.id)
                (3..(routes_linkers.length() + @@walker_title_columns)).each do |x|
                    if worksheet[1,x] == checkpoint.name
                        return
                    end
                end
            end

            col_num = pos + @@walker_title_columns
            
            cols = [[checkpoint.name]]
            cols = Array.new([], cols) if cols.is_a?(Integer)

            # Shifts all cells right of the column
            worksheet.max_cols += cols.size
            worksheet.num_cols.downto(col_num) do |c|
                (1..(worksheet.num_rows)).each do |r|
                    worksheet[r, c + cols.size] = worksheet.input_value(r, c)
                end
            end

            # Fills in the inserted rows.
            num_rows = worksheet.num_rows
            cols.each_with_index do |col, c|
                (0...[num_rows, col.size].max).each do |r|
                    worksheet[1 + r, col_num + c] = col[c] || ''
                end
            end
            worksheet.save
        end
    end

    #when they sign up an event not account
    def add_walker(route, user)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        if worksheet
            walker = Participant.where(user_id: user.id, routes_id: route.id).first
            worksheet.max_rows += 1
            worksheet[(walker.rank + 1), 1] = user.name
            worksheet[(walker.rank + 1), 2] = walker.participant_id
            time = route.start_time
            worksheet[(walker.rank + 1), (1 + @@walker_title_columns)] = time.strftime('%d/%m/%Y %H:%M')
            worksheet.save
        end
    end

    def update_walker_info(route, user)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")

        if worksheet
            walker = Participant.where(user_id: user.id, routes_id: route.id).first
            worksheet[(walker.rank + 1), 1] = user.name
            worksheet[(walker.rank + 1), 2] = walker.participant_id
            worksheet.save
        end
    end

    def update_walker_rank(route, old_rank, user)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        if worksheet
            walker = Participant.where(user_id: user.id, routes_id: route.id).first
            values = worksheet.rows[old_rank]

            if walker.rank > old_rank
                worksheet.insert_rows(walker.rank + 2, [values])
                worksheet.delete_rows(old_rank + 1, 1)
            else
                #when rank increase eg 4 to 2
                worksheet.insert_rows(walker.rank + 1, [values])
                worksheet.delete_rows(old_rank + 2, 1)
            end
            worksheet.save
        end
    end

    def add_checkpoint_time(route, user, checkpoint)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        if worksheet
            walker = Participant.where(user_id: user.id, routes_id: route.id).first 

            pos = RoutesAndCheckpointsLinker.where(route_id: route.id, checkpoint_id: checkpoint.id).first.position_in_route

            #TODO its format is date time so change to just time ?? cant remember what the want reached at 16:00 or took 4 hours?
            time = CheckpointTime.where(participant_id: walker.id, checkpoint_id: checkpoint.id).first.times
            worksheet[(walker.rank + 1), (pos + @@walker_title_columns)] = time.strftime('%d/%m/%Y %H:%M')
            
            worksheet.save
        end
    end

    def walker_drop_out(route, user)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        if worksheet
            walker = Participant.where(user_id: user.id, routes_id: route.id).first
            worksheet[(walker.rank + 1), 3] = "Droped out"
            worksheet[(walker.rank + 1), 4] = "----"
            worksheet.save
        end
    end

    def walker_pickup(route, user)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        if worksheet
            pickup = Pickup.where(user_id: user.id, event_id: Event.where(id: route.event_id).first.id).first
            walker = Participant.where(user_id: user.id, routes_id: route.id).first
            worksheet[(walker.rank + 1), 3] = "Needs Picking Up"
            worksheet[(walker.rank + 1), 4] = pickup.os_grid
            worksheet.save
        end
    end

    #TODO
    def walker_missed_checkpoint
    end
    #need to put something in about if they drop out

    def delete_walker(route, user)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        if worksheet
            walker = Participant.where(user_id: user.id, routes_id: route.id).first
            worksheet.delete_rows((walker.rank+1), 1)
        end
    end

    def upload_event(excel, route)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.event_id).first.name} - #{route.name}")
        #get checkpoint name
        #get checkpoint os grid
        #loop over all the checkpoints#
        
        event = Event.where(id: route.event_id).first
        csv_text = File.read(excel)
        csv = CSV.parse(csv_text, :headers => true)
        count = 0

        csv.each_with_index do |row, i|
            if !(Checkpoint.exists?(name: row[0], event_id: event.id))
                checkpoint = Checkpoint.create(name: row[0], os_grid: (row[1]).gsub(/\s+/, ""), event_id: event.id)
                
            else 
                checkpoint = Checkpoint.where(name: row[0], event_id: event.id).first
               
            end

            count += 1

            if worksheet
                add_checkpoint(route, checkpoint, count, 0)
            end

            if csv.length != i+1
                next_row = csv[i+1]
                advised_time = (next_row[3].to_time - row[3].to_time)/60
            else
                advised_time = 0
            end

            #needs to add description
            if !(RoutesAndCheckpointsLinker.exists?(route_id: route.id, checkpoint_id: checkpoint.id))
                RoutesAndCheckpointsLinker.create(distance_from_start: row[2], checkpoint_description: row[4], advised_time: advised_time, position_in_route: count, route_id: route.id, checkpoint_id: checkpoint.id)
                
            end
            
        end 
    end
end
class Spreadsheet
    require 'bundler'
    Bundler.require
    #https://www.rubydoc.info/gems/google_drive/1.0.5/GoogleDrive
    session = GoogleDrive::Session.from_service_account_key("client_secret.json")

    @@spreadsheet = session.spreadsheet_by_title("softwarehut exported data")
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
    def ex
        worksheet = @@spreadsheet.worksheets.first
        worksheet.insert_rows(worksheet.num_rows + 1, [["This", "was", "added", "From", "code"], ["This", "was", "added", "From", "code"]])
        worksheet.save
    end

    #what if multiple people update the table at once will it mess it up is there a que
    #when updateing and adding checkpoints and times check worksheet exists??
    def add_route(name)
        #check if route already exists but what if they make duplicate events??
        @@spreadsheet.add_worksheet(name, max_rows = 100, max_cols = 20)
    end

    def update_route(old_name, new_name)
        #breaks if thers no worksheet by the name
        worksheet = @@spreadsheet.worksheet_by_title(old_name)
        if worksheet
            worksheet.title = new_name
            worksheet.save
        end
    end

    def delete_route(name)
        #breaks if thers no worksheet by the name
        worksheet = @@spreadsheet.worksheet_by_title(name)
        if worksheet
            worksheet.delete
        end
    end

    def update_event(event, new_event_name)
        #breaks if thers no worksheet by the name
        routes = Route.where(events_id: event.id)
        routes.each do |route|
            worksheet = @@spreadsheet.worksheet_by_title("#{event.name} #{route.name}")
            if worksheet
                worksheet.title = "#{new_event_name} #{route.name}"
                worksheet.save
            end
        end
    end

    def delete_event(event)
        #breaks if thers no worksheet by the name
        routes = Route.where(events_id: event.id)
        routes.each do |route|
            worksheet = @@spreadsheet.worksheet_by_title("#{event.name} #{route.name}")
            if worksheet
                worksheet.delete
            end
        end
    end

    #def add_checkpoint(route, name)
    #    #how the am i gonna add them, need route and checkpoint
    #    worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.events_id).first.name} #{route.name}")
    #    #worksheet.insert_rows(worksheet.num_rows + 1, [["This", "was", "added", "From", "code"], ["This", "was", "added", "From", "code"]])
    #    #worksheet.insert_rows(2, [["This"]])
    #    worksheet(insert_cols(3, [["Thiss"]], worksheet))
    #    worksheet.save 
    #end

    def update_checkpoint(route, old_name, new_name)
    end

    def delete_checkpoint(route, name)
        #needs to close the gap between checkpoints
    end
    
    def add_checkpoint(route, checkpoint)
        #takes over 
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.events_id).first.name} #{route.name}")
        if worksheet["A1"] == ""
            col_num = 1
        else
            checks_linker = RoutesAndCheckpointsLinker.where(route_id: route.id, checkpoint_id:checkpoint.id).first
            routes_linkers = RoutesAndCheckpointsLinker.where(route_id: route.id)
            chosen_linker = routes_linkers.first
            routes_linkers.each do |linker|
                if linker.distance_from_start > chosen_linker.distance_from_start && linker != checks_linker
                    chosen_linker = linker
                end
            end
            routes_linkers.each do |linker|
                if linker.distance_from_start > checks_linker.distance_from_start && linker.distance_from_start < chosen_linker.distance_from_start
                    chosen_linker = linker
                end
            end
            puts "##################################"
            puts chosen_linker.distance_from_start
            puts checks_linker.distance_from_start
            puts chosen_linker.distance_from_start < checks_linker.distance_from_start
            puts "##################################"
            if chosen_linker.distance_from_start < checks_linker.distance_from_start
                col_num = worksheet.num_cols + 1
            else
                chosen_checkpoint = Checkpoint.where(id: chosen_linker.checkpoint_id).first
                col_num= 1
                (1..(routes_linkers.length()+1)).each do |x|
                    puts "##################################"
                    puts worksheet[1,x]
                    puts chosen_checkpoint.name
                    puts worksheet[1,x] == chosen_checkpoint.name
                    puts "##################################"
                    if worksheet[1,x] == chosen_checkpoint.name
                        col_num = x
                    end
                end
            end
            
        end
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
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

    #what if multiple people update the table at once will it mess it up is there a que
    #when updateing and adding checkpoints and times check worksheet exists??
    def add_route(name)
        #check if route already exists but what if they make duplicate events??
        @@spreadsheet.add_worksheet(name, max_rows = 100, max_cols = 20)
        worksheet = @@spreadsheet.worksheet_by_title(name)
        worksheet["A1"] = "Walker Name"
        worksheet["B1"] = "Walker ID"
        worksheet.save
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

    def update_event(old_name, event)
        #breaks if thers no worksheet by the name
        routes = Route.where(events_id: event.id)
        routes.each do |route|
            worksheet = @@spreadsheet.worksheet_by_title("#{old_name} #{route.name}")
            if worksheet
                worksheet.title = "#{event.name} #{route.name}"
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

    def update_checkpoint_name(route, old_name, new_name)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.events_id).first.name} #{route.name}")
        linkers = RoutesAndCheckpointsLinker.where(route_id: route.id)
        (1..(linkers.length()+1)).each do |x|
            if worksheet[1,x] == old_name
                worksheet[1,x] = new_name
                worksheet.save
                break
            end
        end
    end

    def update_checkpoint_position(route, old_name, new_name)
        #worksheet.delete_checkpoint(route, name)
        #worksheet.add_checkpoint(route, checkpoint)
        #copy checkpoint rows and move to end delete checkpoint in middle then insert and delete from end
    end

    def delete_checkpoint(route, name)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.events_id).first.name} #{route.name}") 
        routes_linkers = RoutesAndCheckpointsLinker.where(route_id: route.id)
        #finds the column number
        col_num = 1
        (1..(routes_linkers.length()+1)).each do |x|
            if worksheet[1,x] == name
                col_num = x
                break
            end
        end
        
        #double checks if the chosen cell has the same name
        if worksheet[1,col_num] != name
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
    
    def add_checkpoint(route, checkpoint)
        worksheet = @@spreadsheet.worksheet_by_title("#{Event.where(id: route.events_id).first.name} #{route.name}") 

        #checks if the checkpoint is already in the spreadsheeta and returns if it is
        routes_linkers = RoutesAndCheckpointsLinker.where(route_id: route.id)
        (1..(routes_linkers.length()+1)).each do |x|
            if worksheet[1,x] == checkpoint.name
                return
            end
        end

        #postion + walker column titles for the column number to add to
        checkpoint_linker = RoutesAndCheckpointsLinker.where(route_id: route.id, checkpoint_id:checkpoint.id).first
        col_num = checkpoint_linker.position_in_route + 2
        
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
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

    def add_checkpoint(name)
        #how the am i gonna add them, need route and checkpoint
    end

    def update_checkpoint(old_name, new_name)
    end

    def delete_checkpoint(name)
        #needs to close the gap between checkpoints
    end
end
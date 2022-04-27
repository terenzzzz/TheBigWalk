require 'bundler'
Bundler.require
#https://www.rubydoc.info/gems/google_drive/1.0.5/GoogleDrive
session = GoogleDrive::Session.from_service_account_key("client_secret.json")

@spreadsheet = session.spreadsheet_by_title("softwarehut exported data")
#first worksheet
@worksheet = spreadsheet.worksheets.first

#pull data
#worksheet.rows.first(10).each { |row| puts row.first(6).reverse.join(" | ") }

#get worksheet by title
#spreadsheet.worksheet_by_title("Sheet1")

#add worksheet
#spreadsheet.add_worksheet("bob", max_rows = 100, max_cols = 20)

#insert row
#worksheet.insert_rows(worksheet.num_rows + 1, [["This", "was", "added", "From", "code"], ["This", "was", "added", "From", "code"]])
#worksheet.save

#update cell
#worksheet["A1"] = "bob"
#worksheet.save

#delete 14th and 15 rows
#worksheet.delete_rows(14, 2)
#worksheet.save


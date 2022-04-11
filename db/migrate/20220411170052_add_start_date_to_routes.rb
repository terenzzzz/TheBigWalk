class AddStartDateToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :start_date, :date
  end
end

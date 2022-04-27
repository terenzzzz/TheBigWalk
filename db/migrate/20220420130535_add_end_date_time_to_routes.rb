class AddEndDateTimeToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :end_date_time, :datetime
  end
end

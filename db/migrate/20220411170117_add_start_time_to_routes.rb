class AddStartTimeToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :start_time, :time
  end
end

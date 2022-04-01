class DropCheckPoint < ActiveRecord::Migration[6.1]
  def change
    drop_table :check_points
  end
end

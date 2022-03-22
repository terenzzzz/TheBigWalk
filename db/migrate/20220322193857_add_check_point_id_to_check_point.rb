class AddCheckPointIdToCheckPoint < ActiveRecord::Migration[6.1]
  def change
    add_column :check_points, :check_point_id, :integer
  end
end

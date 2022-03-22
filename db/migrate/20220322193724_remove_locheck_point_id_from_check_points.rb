class RemoveLocheckPointIdFromCheckPoints < ActiveRecord::Migration[6.1]
  def change
    remove_column :check_points, :locheck_point_id, :integer
  end
end

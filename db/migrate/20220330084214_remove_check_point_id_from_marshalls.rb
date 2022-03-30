class RemoveCheckPointIdFromMarshalls < ActiveRecord::Migration[6.1]
  def change
    remove_column :marshalls, :check_point_id, :integer
  end
end

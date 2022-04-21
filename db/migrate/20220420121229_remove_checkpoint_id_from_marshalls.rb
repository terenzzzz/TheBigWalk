class RemoveCheckpointIdFromMarshalls < ActiveRecord::Migration[6.1]
  def change
    remove_column :marshalls, :checkPoint_id, :integer
  end
end

class ChangeCheckpointsIdToNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :marshalls, :checkpoints_id, true 
  end
end

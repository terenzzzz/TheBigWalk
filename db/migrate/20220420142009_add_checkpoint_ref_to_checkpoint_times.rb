class AddCheckpointRefToCheckpointTimes < ActiveRecord::Migration[6.1]
  def change
    add_reference :checkpoint_times, :checkpoint, null: false, foreign_key: true
  end
end

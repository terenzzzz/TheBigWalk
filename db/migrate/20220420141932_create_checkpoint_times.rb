class CreateCheckpointTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :checkpoint_times do |t|
      t.datetime :times

      t.timestamps
    end
  end
end

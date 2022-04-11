class RemoveAdvisedTimeFromCheckpoints < ActiveRecord::Migration[6.1]
  def change
    remove_column :checkpoints, :advisedTime, :integer
  end
end

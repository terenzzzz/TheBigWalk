class RemoveDistanceFromCheckpoints < ActiveRecord::Migration[6.1]
  def change
    remove_column :checkpoints, :distance, :float
  end
end

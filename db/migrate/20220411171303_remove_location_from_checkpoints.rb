class RemoveLocationFromCheckpoints < ActiveRecord::Migration[6.1]
  def change
    remove_column :checkpoints, :location, :string
  end
end

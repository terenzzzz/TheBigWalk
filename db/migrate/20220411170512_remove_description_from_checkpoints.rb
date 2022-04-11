class RemoveDescriptionFromCheckpoints < ActiveRecord::Migration[6.1]
  def change
    remove_column :checkpoints, :description, :string
  end
end

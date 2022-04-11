class AddOsGridToCheckpoints < ActiveRecord::Migration[6.1]
  def change
    add_column :checkpoints, :os_grid, :string
  end
end

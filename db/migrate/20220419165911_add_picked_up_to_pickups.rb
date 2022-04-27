class AddPickedUpToPickups < ActiveRecord::Migration[6.1]
  def change
    add_column :pickups, :picked_up, :boolean
  end
end

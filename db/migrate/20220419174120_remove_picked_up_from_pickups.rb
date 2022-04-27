class RemovePickedUpFromPickups < ActiveRecord::Migration[6.1]
  def change
    remove_column :pickups, :picked_up, :boolean
  end
end

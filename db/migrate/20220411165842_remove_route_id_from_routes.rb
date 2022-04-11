class RemoveRouteIdFromRoutes < ActiveRecord::Migration[6.1]
  def change
    remove_column :routes, :route_id, :integer
  end
end

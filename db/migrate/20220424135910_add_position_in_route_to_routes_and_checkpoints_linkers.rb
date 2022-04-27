class AddPositionInRouteToRoutesAndCheckpointsLinkers < ActiveRecord::Migration[6.1]
  def change
    add_column :routes_and_checkpoints_linkers, :position_in_route, :integer
  end
end

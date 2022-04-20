class RemoveRouteIdFromParticipants < ActiveRecord::Migration[6.1]
  def change
    remove_column :participants, :route_id, :integer
  end
end

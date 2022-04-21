class RemoveCheckPointIdFromParticipants < ActiveRecord::Migration[6.1]
  def change
    remove_column :participants, :check_point_id, :integer
  end
end

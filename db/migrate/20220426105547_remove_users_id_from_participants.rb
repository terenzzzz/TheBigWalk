class RemoveUsersIdFromParticipants < ActiveRecord::Migration[6.1]
  def change
    remove_column :participants, :users_id, :integer

  end
end

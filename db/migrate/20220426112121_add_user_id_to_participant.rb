class AddUserIdToParticipant < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :user_id, :bigint, null: false
  end
end

class AddUserRefToParticipant < ActiveRecord::Migration[6.1]
  def change
    #add_column :participants, :user_id, :bigint, null: false
    add_reference :participants, :user, null: false, foreign_key: true
  end
end

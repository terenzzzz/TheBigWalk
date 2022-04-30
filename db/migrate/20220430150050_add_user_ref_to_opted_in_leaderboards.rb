class AddUserRefToOptedInLeaderboards < ActiveRecord::Migration[6.1]
  def change
    add_reference :opted_in_leaderboards, :user, null: false, foreign_key: true
  end
end

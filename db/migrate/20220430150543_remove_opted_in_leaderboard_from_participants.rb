class RemoveOptedInLeaderboardFromParticipants < ActiveRecord::Migration[6.1]
  def change
    remove_column :participants, :opted_in_leaderboard, :boolean
  end
end

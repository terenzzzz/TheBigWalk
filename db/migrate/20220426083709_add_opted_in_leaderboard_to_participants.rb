class AddOptedInLeaderboardToParticipants < ActiveRecord::Migration[6.1]
  def change
    add_column :participants, :opted_in_leaderboard, :boolean, :null => false, :default => false
  end
end

class CreateOptedInLeaderboards < ActiveRecord::Migration[6.1]
  def change
    create_table :opted_in_leaderboards do |t|
      t.boolean :opted_in

      t.timestamps
    end
  end
end

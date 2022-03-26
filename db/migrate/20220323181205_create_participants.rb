class CreateParticipants < ActiveRecord::Migration[6.1]
  def change
    create_table :participants do |t|
      t.integer :participant_id
      t.string :pace
      t.datetime :arrival_time
      t.integer :rank
      t.string :status
      t.integer :user_id
      t.integer :route_id
      t.integer :check_point_id

      t.timestamps
    end
  end
end

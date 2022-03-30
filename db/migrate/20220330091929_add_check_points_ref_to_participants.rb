class AddCheckPointsRefToParticipants < ActiveRecord::Migration[6.1]
  def change
    add_reference :participants, :checkpoints, null: false, foreign_key: true
  end
end

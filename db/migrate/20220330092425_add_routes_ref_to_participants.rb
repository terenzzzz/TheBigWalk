class AddRoutesRefToParticipants < ActiveRecord::Migration[6.1]
  def change
    add_reference :participants, :routes, null: false, foreign_key: true
  end
end

class AddUsersRefToPickups < ActiveRecord::Migration[6.1]
  def change
    add_reference :pickups, :user, null: false, foreign_key: true
  end
end

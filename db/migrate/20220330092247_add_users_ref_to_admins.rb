class AddUsersRefToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_reference :admins, :users, null: false, foreign_key: true
  end
end

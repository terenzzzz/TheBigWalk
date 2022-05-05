class AddUserRefToMarshalls < ActiveRecord::Migration[6.1]
  def change
    add_reference :marshalls, :user, null: false, foreign_key: true
  end
end

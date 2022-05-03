class ChangePhontNumberTypeToEvent < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :phone_number, :integer
    add_column :events, :phone_number, :string
  end
end

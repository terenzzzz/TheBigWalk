class AddDonateLinkToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :donate_link, :string
  end
end

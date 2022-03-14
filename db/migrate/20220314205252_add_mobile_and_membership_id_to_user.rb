class AddMobileAndMembershipIdToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :mobile, :string
    add_column :users, :membership_id, :string
  end
end

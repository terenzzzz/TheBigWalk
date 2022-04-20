class RemoveUserIdFromMarshalls < ActiveRecord::Migration[6.1]
  def change
    remove_column :marshalls, :user_id, :integer
  end
end

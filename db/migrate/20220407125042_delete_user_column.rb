class DeleteUserColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :tags_id, :integer
    
  end
end

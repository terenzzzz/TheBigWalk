class AddTagRelationToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :tag, foreign_key: true
  end
end

class AddRelationshipToUser < ActiveRecord::Migration[6.1]
  def change
    :user.belongs_to :tag, foreign_key: true
  end
end

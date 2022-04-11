class RemoveLengthFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :length, :integer
  end
end

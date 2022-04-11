class RemoveLengthFromRoutes < ActiveRecord::Migration[6.1]
  def change
    remove_column :routes, :length, :integer
  end
end

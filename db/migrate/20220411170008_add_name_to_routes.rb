class AddNameToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :name, :string
  end
end

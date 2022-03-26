class CreateRoutes < ActiveRecord::Migration[6.1]
  def change
    create_table :routes do |t|
      t.integer :route_id
      t.string :length

      t.timestamps
    end
  end
end

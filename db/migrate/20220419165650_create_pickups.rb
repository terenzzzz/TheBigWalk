class CreatePickups < ActiveRecord::Migration[6.1]
  def change
    create_table :pickups do |t|
      t.string :os_grid

      t.timestamps
    end
  end
end

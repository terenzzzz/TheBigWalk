class CreateLinkers < ActiveRecord::Migration[6.1]
  def change
    create_table :linkers do |t|
      t.float :distance_from_start
      t.string :checkpoint_description
      t.integer :advised_time

      t.timestamps
    end
  end
end

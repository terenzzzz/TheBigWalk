class CreateCheckPoints < ActiveRecord::Migration[6.1]
  def change
    create_table :check_points do |t|
      t.integer :locheck_point_id
      t.string :location
      t.string :advice_time
      t.string :code
      t.string :grid_reference

      t.timestamps
    end
  end
end

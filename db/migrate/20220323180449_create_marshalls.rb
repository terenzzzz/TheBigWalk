class CreateMarshalls < ActiveRecord::Migration[6.1]
  def change
    create_table :marshalls do |t|
      t.integer :marshal_id
      t.integer :checkPoint_id
      t.integer :check_point_id

      t.timestamps
    end
  end
end

class CreateMarshalShift < ActiveRecord::Migration[6.1]
  def change
    create_table :marshal_shifts do |t|
      t.datetime :current_time
      t.string :status

      t.timestamps
    end
  end
end

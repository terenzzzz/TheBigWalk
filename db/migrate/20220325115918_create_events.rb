class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.time :time
      t.integer :length
      t.integer :eventID

      t.timestamps
    end
  end
end

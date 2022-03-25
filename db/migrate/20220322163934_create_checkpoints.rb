class CreateCheckpoints < ActiveRecord::Migration[6.1]
  def change
    create_table :checkpoints do |t|
      t.string :name
      t.float :distance
      t.string :location
      t.integer :advisedTime
      t.string :description

      t.timestamps
    end
  end
end

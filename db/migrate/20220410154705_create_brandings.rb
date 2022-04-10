class CreateBrandings < ActiveRecord::Migration[6.1]
  def change
    create_table :brandings do |t|
      t.string :btn_colour

      t.timestamps
    end
  end
end

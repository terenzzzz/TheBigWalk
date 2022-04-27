class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.string :subject
      t.string :description
      t.integer :user_id

      t.timestamps
    end
  end
end

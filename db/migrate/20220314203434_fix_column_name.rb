class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :descrition, :description
  end
end

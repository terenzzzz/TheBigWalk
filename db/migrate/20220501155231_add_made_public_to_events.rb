class AddMadePublicToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :made_public, :boolean
  end
end

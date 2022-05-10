class AddEventsRefToBranding < ActiveRecord::Migration[6.1]
  def change
    add_reference :brandings, :event, null: false, foreign_key: true
  end
end

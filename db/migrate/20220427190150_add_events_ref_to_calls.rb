class AddEventsRefToCalls < ActiveRecord::Migration[6.1]
  def change
    add_reference :calls, :event, null: false, foreign_key: true
  end
end

class AddEventsRefToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_reference :routes, :event, null: false, foreign_key: true
  end
end

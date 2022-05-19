class AddEventsRefToCheckpoints < ActiveRecord::Migration[6.1]
  def change
    add_reference :checkpoints, :event, null: false, foreign_key: true
  end
end

class RemoveEventsRefFromCheckpoints < ActiveRecord::Migration[6.1]
  def change
    remove_reference :checkpoints, :events, null: false, foreign_key: true
  end
end

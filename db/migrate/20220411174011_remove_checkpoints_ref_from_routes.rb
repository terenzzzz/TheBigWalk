class RemoveCheckpointsRefFromRoutes < ActiveRecord::Migration[6.1]
  def change
    remove_reference :routes, :checkpoints, null: false, foreign_key: true
  end
end

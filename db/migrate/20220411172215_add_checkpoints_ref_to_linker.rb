class AddCheckpointsRefToLinker < ActiveRecord::Migration[6.1]
  def change
    add_reference :linkers, :checkpoint, null: false, foreign_key: true
  end
end

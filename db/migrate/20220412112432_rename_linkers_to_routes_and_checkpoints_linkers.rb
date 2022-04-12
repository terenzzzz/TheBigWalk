class RenameLinkersToRoutesAndCheckpointsLinkers < ActiveRecord::Migration[6.1]
  def change
    rename_table :linkers, :routes_and_checkpoints_linkers
  end
end

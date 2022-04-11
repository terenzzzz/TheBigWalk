class AddRoutesRefToLinker < ActiveRecord::Migration[6.1]
  def change
    add_reference :linkers, :route, null: false, foreign_key: true
  end
end

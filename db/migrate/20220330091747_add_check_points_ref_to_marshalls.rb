class AddCheckPointsRefToMarshalls < ActiveRecord::Migration[6.1]
  def change
    add_reference :marshalls, :checkpoints, null: false, foreign_key: true
  end
end

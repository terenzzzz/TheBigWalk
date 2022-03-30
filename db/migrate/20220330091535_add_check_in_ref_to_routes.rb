class AddCheckInRefToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_reference :routes, :checkpoints, null: false, foreign_key: true
  end
end

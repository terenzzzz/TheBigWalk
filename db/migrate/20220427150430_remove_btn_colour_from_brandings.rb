class RemoveBtnColourFromBrandings < ActiveRecord::Migration[6.1]
  def change
    remove_column :brandings, :btn_colour, :string
  end
end

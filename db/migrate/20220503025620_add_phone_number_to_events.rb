class AddPhoneNumberToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :phone_number, :integer
  end
end

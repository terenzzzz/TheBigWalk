class AddMarshallsIdtoMarshalShift < ActiveRecord::Migration[6.1]
  def change
    add_reference :marshal_shifts, :marshalls, foreign_key: true
  end
end

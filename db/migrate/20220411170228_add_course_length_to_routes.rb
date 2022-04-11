class AddCourseLengthToRoutes < ActiveRecord::Migration[6.1]
  def change
    add_column :routes, :course_length, :integer
  end
end

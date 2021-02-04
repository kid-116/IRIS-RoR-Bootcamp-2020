class AddCourseToAssignments < ActiveRecord::Migration[6.1]
  def change
    add_column :assignments, :course_id, :integer
  end
end

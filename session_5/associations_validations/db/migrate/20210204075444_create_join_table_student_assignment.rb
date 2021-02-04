class CreateJoinTableStudentAssignment < ActiveRecord::Migration[6.1]
  def change
    create_join_table :students, :assignments do |t|
      # t.index [:student_id, :assignment_id]
      # t.index [:assignment_id, :student_id]
    end
  end
end

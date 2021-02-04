class AddBranchToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :branch_id, :integer
  end
end

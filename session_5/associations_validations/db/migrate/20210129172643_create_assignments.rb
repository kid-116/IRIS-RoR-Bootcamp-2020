class CreateAssignments < ActiveRecord::Migration[6.1]
  def change
    create_table :assignments do |t|
      t.string :name
      t.decimal :weightage
      t.datetime :deadline

      t.timestamps
    end
  end
end

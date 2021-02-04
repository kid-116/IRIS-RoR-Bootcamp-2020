# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_04_075444) do

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.decimal "weightage"
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
  end

  #To track submissions
  create_table "assignments_students", id: false, force: :cascade do |t| 
    t.integer "student_id", null: false
    t.integer "assignment_id", null: false
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "year"
    t.integer "credits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "branch_id"
  end

  create_table "courses_students", id: false, force: :cascade do |t|
    t.integer "course_id", null: false
    t.integer "student_id", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "admission_year"
    t.string "email"
    t.string "roll_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "branch_id"
  end

end

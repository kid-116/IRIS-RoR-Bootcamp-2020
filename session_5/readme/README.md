SCHEMA

ActiveRecord::Schema.define(version: 2021_01_30_150003) do

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.decimal "weightage"
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
    t.index ["course_id"], name: "index_assignments_on_course_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "course_id"
    t.integer "student_id"
    t.index ["course_id"], name: "index_branches_on_course_id"
    t.index ["student_id"], name: "index_branches_on_student_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.integer "year"
    t.integer "credits"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "branch_id"
    t.integer "student_id"
    t.integer "assignment_id"
    t.index ["assignment_id"], name: "index_courses_on_assignment_id"
    t.index ["branch_id"], name: "index_courses_on_branch_id"
    t.index ["student_id"], name: "index_courses_on_student_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "admission_year"
    t.string "email"
    t.string "roll_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "branch_id"
    t.integer "course_id"
    t.index ["branch_id"], name: "index_students_on_branch_id"
    t.index ["course_id"], name: "index_students_on_course_id"
  end

end

VALIDATIONS & ASSOCIATIONS

class Branch < ApplicationRecord
    has_many :courses
    has_many :students

    validates :name, presence: true, inclusion: {
        :in => ['Computer Science and Engineering', 'Mechanical Engineering', 'Mining Engineering', 'Electronics and Communication Engineering'],
        message: "%{value} is not a valid branch."
    }
    
    validates :code, presence: true, uniqueness: true
end

class Course < ApplicationRecord
    belongs_to :branch
    has_many :students
    has_many :assignments

    validates_associated :branch

    validates :name, presence: true

    validates :code, presence: true, uniqueness: true
    validate :check_code

    validates :year, presence: true, numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 4
    }

    validates :credits, presence: true, numericality: {
        greater_than: 0,
        less_than_or_equal_to: 6
    }
end

def check_code
    if !(code.start_with? branch.code)
        errors.add(:code, "Invalid")
    else
        if(code[branch.code.length..-1].length == 3) 
            if !(code[branch.code.length..-1].scan(/\D/).empty?)
                errors.add(:code, "Invalid")
            end
        elsif
            errors.add(:code, "Invalid")
        end
    end
end

class Assignment < ApplicationRecord
    belongs_to :course

    validates_associated :course

    validates :name, presence: true

    validates :weightage, presence: true, numericality: {
        greater_than: 0,
        less_than_or_equal_to: 50
    }

    validates :deadline, presence: true
    validate :check_deadline
end

def check_deadline
    if deadline < Time.now
        errors.add(:deadline, "Invalid")
    end
end

class Student < ApplicationRecord
    belongs_to :branch
    has_many :courses

    validates_associated :branch
    
    validates :name, presence: true

    validates :roll_no, presence: true, uniqueness: true
    validate :check_roll
    
    validates :admission_year, presence: true
    
    validates :email, presence: true
end

def check_roll 
    if !(roll_no.start_with? ((admission_year % 100).to_s))
        errors.add(:roll_no, "Invalid")
    elsif !(roll_no[2..-1].start_with? branch.code)
        errors.add(:roll_no, "Invalid")
    elsif (roll_no[(2 + branch.code.length)..-1].length != 3)
        errors.add(:roll_no, "Invalid")
    elsif !(roll_no[(2 + branch.code.length)..-1].scan(/\D/).empty?)
        errors.add(:roll_no, "Invalid")
    end
end

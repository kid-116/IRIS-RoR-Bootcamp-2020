SCHEMA
```ruby
ActiveRecord::Schema.define(version: 2021_01_30_150003) do

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.decimal "weightage"
    t.datetime "deadline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "admission_year"
    t.string "email"
    t.string "roll_no"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
```
MODELS
```ruby
class Branch < ApplicationRecord
    has_many :courses
    has_many :students

    validates :name, presence: true, inclusion: {
        :in => ['Computer Science and Engineering', 'Mechanical Engineering', 'Mining Engineering', 'Electronics and Communication Engineering'],
        message: "%{value} is not a valid branch."
    }
    
    validates :code, presence: true, uniqueness: true
end
```
```ruby
class Course < ApplicationRecord
    belongs_to :branch
    has_many :students
    has_many :assignments

    validates_associated :branch

    validates :name, presence: true

    validates :code, presence: true, uniqueness: true
    validate :code_must_start_with_branch_code, :code_must_end_with_three_digits

    validates :year, presence: true, numericality: {
        greater_than_or_equal_to: 1,
        less_than_or_equal_to: 4
    }

    validates :credits, presence: true, numericality: {
        greater_than: 0,
        less_than_or_equal_to: 6
    }
end

def code_must_start_with_branch_code
    if !(code.start_with? branch.code)
        errors.add(:code, "Invalid prefix for code")
    end
end

def code_must_end_with_three_digits
    if(code[branch.code.length..-1].length == 3) 
        if !(code[branch.code.length..-1].scan(/\D/).empty?)
            errors.add(:code, "Invalid serial number")
        end
    elsif
        errors.add(:code, "Invalid length of serial number")
    end
end
```
```ruby
class Assignment < ApplicationRecord
    belongs_to :course

    validates_associated :course

    validates :name, presence: true

    validates :weightage, presence: true, numericality: {
        less_than_or_equal_to: 50
    }

    validates :deadline, presence: true
    validate :deadline_must_be_in_future
end

def deadline_must_be_in_future
    if deadline < Time.now
        errors.add(:deadline, "Deadline has already passed")
    end
end
```
```ruby
class Student < ApplicationRecord
    belongs_to :branch
    has_many :courses

    validates_associated :branch
    
    validates :name, presence: true

    validates :roll_no, presence: true, uniqueness: true
    validate :roll_must_start_with_last_two_digits_of_admission_year, :roll_must_contain_branch_code, :roll_must_end_with_three_digits
    
    validates :admission_year, presence: true
    
    validates :email, presence: true
end

def roll_must_start_with_last_two_digits_of_admission_year
    if !(roll_no.start_with? ((admission_year % 100).to_s))
        errors.add(:roll_no, "Invalid prefix")
    end
end

def roll_must_contain_branch_code
    if !(roll_no[2..-1].start_with? branch.code)
        errors.add(:roll_no, "Invalid branch code")
    end
end

def roll_must_end_with_three_digits
    if (roll_no[(2 + branch.code.length)..-1].length != 3)
        errors.add(:roll_no, "Invalid serial number length")
    elsif !(roll_no[(2 + branch.code.length)..-1].scan(/\D/).empty?)
        errors.add(:roll_no, "Invalid serial number")
    end
end
```

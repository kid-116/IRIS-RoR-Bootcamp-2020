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
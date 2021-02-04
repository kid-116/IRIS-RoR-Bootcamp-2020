class Course < ApplicationRecord
    belongs_to :branch
    #TODO
    has_and_belongs_to_many :students
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

class CGPAValidator < ActiveModel::Validator
    def validate(record)
        unless record.cgpa > 0 and record.cgpa < 10
            raise ArgumentError, "Invalid CGPA"
        end
    end
end

class Student < ApplicationRecord
    include ActiveModel::Validations
    validates_with CGPAValidator
end

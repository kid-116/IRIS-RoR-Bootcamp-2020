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

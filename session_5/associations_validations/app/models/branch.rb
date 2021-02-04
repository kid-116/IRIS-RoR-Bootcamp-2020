class Branch < ApplicationRecord
    has_many :courses
    has_many :students

    validates :name, presence: true, inclusion: {
        :in => ['Computer Science and Engineering', 'Mechanical Engineering', 'Mining Engineering', 'Electronics and Communication Engineering'],
        message: "%{value} is not a valid branch."
    }
    
    validates :code, presence: true, uniqueness: true
end



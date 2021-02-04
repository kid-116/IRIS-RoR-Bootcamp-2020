module ApplicationHelper
    def register(student_name, course_code)
        Student.find_by(name: student_name).courses<<Course.find_by(code: course_code) 
    end

    def submit(student_name, assignment_id)
        if Assignment.find(assignment_id).deadline >= Time.now
            print("Submission successful")
        else
            print("Submission window has closed")
        end
    end
end

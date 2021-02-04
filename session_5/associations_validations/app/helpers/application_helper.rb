module ApplicationHelper
    def register(student_roll_no, course_code)
        Student.find_by(roll_no: student_roll_no).courses<<Course.find_by(code: course_code) 
    end

    def submit(student_roll_no, assignment_id)
        if Assignment.find(assignment_id).deadline >= Time.now
            print("Submission successful")
            Student.find_by(roll_no: student_roll_no).assignments<<Assignment.find(assignment_id)
        else
            print("Submission window has closed")
        end
    end
end

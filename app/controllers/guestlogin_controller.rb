class GuestloginController < ApplicationController
    def adminlogin
        @university = University.find_by email: 'admin@univmeet.com'
        if @university.present?
            if @university.valid_password?("password")
                sign_in @university
                redirect_to "/universities/landing"
            end
        end
    end
    
    def universitylogin
        @university = University.find_by(email: "joi@fisher-powlowski.com")
        if @university.present?
            if @university.valid_password?("password")
                sign_in @university
                redirect_to "/universities/landing"
            end
        end
    end
    
    def studentlogin
        @student = Student.find_by(email: "emilio@koelpin.net")
        if @student.present?
            if @student.valid_password?("password")
                sign_in @student
                redirect_to "/students/landing"
            end
        end
    end
    
end

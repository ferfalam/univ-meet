class GuestloginController < ApplicationController
    def adminlogin
        @university = University.where(valid_account: true, admin: true).limit(1)[0]
        if @university.present?
            if @university.valid_password?("password")
                sign_in @university
                redirect_to "/universities/landing"
            end
        end
    end
    
    def universitylogin
        @university = University.where(valid_account: true, admin: false).limit(1)[0]
        if @university.present?
            if @university.valid_password?("password")
                sign_in @university
                redirect_to "/universities/landing"
            end
        end
    end
    
    def studentlogin
        @student = Student.where(valid_account: true).limit(1)[0]
        if @student.present?
            if @student.valid_password?("password")
                sign_in @student
                redirect_to "/students/landing"
            end
        end
    end
    
end

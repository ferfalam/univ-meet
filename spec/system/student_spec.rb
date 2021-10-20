require 'rails_helper'
RSpec.describe 'Student', type: :system do
    it 'can login' do
        @student = Student.create(
            firstname: 'john',
            lastname: "doe",
            phone_number: "11111111",
            personal_number: '22222222',
            email: 'johndoe@gmail.com',
            card_image: "image",
            university: 1,
            field: 1,
            password: "password"
        )

        puts @student.errors.messages


        # visit "/students/sign_in"

        # fill_in "email",	with: @student.email
        # fill_in "password",	with: "password"

        # click_on "Se connecter"

        # expect(page).to have_content @student.firstname
    end
end
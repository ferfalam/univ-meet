require 'rails_helper'
RSpec.describe 'Student', type: :system do
    before do
        @university = University.create(
            name: "doe",
            acronym: "11111111",
            email: "email@email.com",
            password: "password"
        )
        @field = Field.create({
            name: "field A",
            acronym: "FA",
            university: @university
        })
        @student = Student.create(
            firstname: 'john',
            lastname: "doe",
            phone_number: "11111111",
            personal_number: '22222222',
            email: 'johndoe@gmail.com',
            card_image: "https://fakeimg.pl/250x100/",
            university: @university,
            password: "password",
            valid_until: "12/10/2021",
            field: @field
        )
        @request = Request.create({
            title: "Req A",
            description: "Some content",
        })
    end

    after do
        @university.destroy
        @field.destroy
        @student.destroy
        @request.destroy
    end
    
    it 'can login' do
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        
        click_on "Se connecter"
        expect(page).to have_content @student.email
    end

    it "return to edit page if invalid" do
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Acceuil"
        expect(page).to have_content "Votre compte n'est pas encore valide, veuillez patienter"
    end 

    it "can make post" do
        @student.update(valid_account: true)
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        fill_in "Publier un post",	with: "This is a post with test" 
        click_on "Publier"

        expect(page).to have_content "Post créée avec succès"
    end

    it "can make comment" do
        @student.update(valid_account: true)
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        click_on "Se connecter"

        fill_in "Publier un post",	with: "This is a post with test" 
        click_on "Publier"
        
        fill_in "Commentaire",	with: "My comment" 
        click_on "Commenter"

        expect(page).to have_content "Commentaire créé avec succès"
    end

    it "can update post" do
        @student.update(valid_account: true)
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        click_on "Se connecter"

        fill_in "Publier un post",	with: "This is a post with test" 
        click_on "Publier"
        click_on "Mes posts"
        click_on "Modifier"
        fill_in "Modifier votre post",	with: "Post Update test" 
        click_on "Confirmer"
        

        expect(page).to have_content "Post Update test"
    end

    it "can delete post" do
        @student.update(valid_account: true)
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        click_on "Se connecter"

        fill_in "Publier un post",	with: "This is a post with test" 
        click_on "Publier"
        click_on "Mes posts"
        click_on "Supprimer"
        

        expect(page).to have_content "Post supprimer avec succès"
    end
    
    it "can make request" do
        @student.update(valid_account: true)
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Faire une demande"
        fill_in "Titre de la demande",	with: "Request A" 
        fill_in "Description de la demande",	with: "Description A" 
        click_on "Faire la demande"

        expect(page).to have_content "Demande créée avec succès"
    end

    it "can delete request" do
        @student.update(valid_account: true)
        visit "/students/sign_in"
        
        fill_in "email",	with: @student.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Faire une demande"
        fill_in "Titre de la demande",	with: "Request A" 
        fill_in "Description de la demande",	with: "Description A" 
        click_on "Faire la demande"
        click_on "Supprimer"

        expect(page).to have_content "Demande supprimer avec succès"
    end
end
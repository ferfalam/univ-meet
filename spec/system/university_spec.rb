require 'rails_helper'
RSpec.describe 'University', type: :system do
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
            university: @university
        })
    end

    after do
        @university.destroy
        @field.destroy
        @student.destroy
        @request.destroy
    end
    
    
    it 'can login' do
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        
        click_on "Se connecter"
        expect(page).to have_content @university.name
    end

    it "return to edit page if invalid" do
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Tableau de bord"
        expect(page).to have_content "Votre compte n'est pas encore valide, veuillez patienter"
    end 
    
    it "can make field" do
        @university.update(valid_account: true)
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Filières"
        fill_in "Nom complet de la filière",	with: "Request A" 
        fill_in "Diminutif de la filière",	with: "Description A" 
        click_on "Créer une filière"
        
        expect(page).to have_content "Filière créée avec succès"
    end

    it "can update field" do
        @university.update(valid_account: true)
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Filières"
        fill_in "Modifier nom complet de la filière",	with: "Request A update" 
        fill_in "Modifier diminutif de la filière",	with: "Description A update" 
        click_on "Créer une filière"
        
        expect(page).to have_content "Request A update"
    end

    it "can delete field" do
        @university.update(valid_account: true)
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Filières"
        click_on "Supprimer"

        expect(page).to have_content "Filière supprimer avec succès"
    end

    it "can approve request" do
        @university.update(valid_account: true)
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Demandes"
        click_on "Approuvée"

        expect(page).to have_content "Vous aviez approuvé cette demande"
    end

    it "can rejet request" do
        @university.update(valid_account: true)
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Demandes"
        click_on "Rejetée"

        expect(page).to have_content "Vous aviez rejeté cette demande"
    end

    it "can valid student account" do
        @university.update(valid_account: true)
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Etudiants"
        click_on "Valider le compte"

        expect(page).to have_content "Validation Etudiant"
    end

    it "can invalid student account" do
        @university.update(valid_account: true)
        visit "/universities/sign_in"
        
        fill_in "email",	with: @university.email
        fill_in "password",	with: "password"
        click_on "Se connecter"
        
        click_on "Etudiants"
        click_on "Invalider le compte"
        fill_in "Cause d'invalidation du compte",	with: "Cause voilà" 
        click_on "Confirmer l'invalidation du compte"

        expect(page).to have_content "Message d'invalidation transmis à l'étudiant."
    end
end

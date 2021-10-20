require 'rails_helper'

RSpec.describe Student, type: :model do
  it "is invalid without firstname" do
    student = Student.create(
      university_id: 1,
      field_id: 1
    )

    expect(student.errors[:firstname]).to include("Prénom ne peut pas être vide")
  end

  it "is invalid without lastname" do
    student = Student.create(
      firstname: 'john',
      university_id: 1,
      field_id: 1
    )

    expect(student.errors[:lastname]).to include("Nom ne peut pas être vide")
  end

  it "is invalid without phone_number" do
    student = Student.create(
      firstname: 'john',
      lastname: "doe",
      university_id: 1,
      field_id: 1
    )

    expect(student.errors[:phone_number]).to include("Entrez numéro de téléphone")
  end
  
  it "is invalid without personal_number" do
    student = Student.create(
      firstname: 'john',
      lastname: "doe",
      phone_number: "11111111",
      university_id: 1,
      field_id: 1
    )

    expect(student.errors[:personal_number]).to include("Entrez numéro matricule")
  end
  
  it "is invalid without email" do
    student = Student.create(
      firstname: 'john',
      lastname: "doe",
      phone_number: "11111111",
      personal_number: '22222222',
      university_id: 1,
      field_id: 1
    )

    expect(student.errors[:email]).to include("L'email ne peut pas être vide")
  end
  
  it "is invalid without card_image" do
    student = Student.create(
      firstname: 'john',
      lastname: "doe",
      phone_number: "11111111",
      personal_number: '22222222',
      email: 'johndoe@gmail.com',
      university_id: 1,
      field_id: 1
    )

    expect(student.errors[:card_image]).to include("Insérer votre carte d'étudiant")
  end

  it "is invalid without password" do
    student = Student.create(
      firstname: 'john',
      lastname: "doe",
      phone_number: "11111111",
      personal_number: '22222222',
      email: 'johndoe@gmail.com',
      university_id: 1,
      field_id: 1
    )

    expect(student.errors[:password]).to include("Mot de passe ne peut pas être vide")
  end

  it "is valid all required" do
    student = Student.create(
      firstname: 'john',
      lastname: "doe",
      phone_number: "11111111",
      personal_number: '22222222',
      email: 'johndoe@gmail.com',
      card_image: "image",
      university_id: 1,
      field_id: 1
    )

    expect(student.phone_number).to include("11111111")
  end
end

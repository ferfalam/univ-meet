require 'rails_helper'

RSpec.describe University, type: :model do 
  it "is invalid without email" do
    university = University.create(
      name: "doe",
      acronym: "11111111",
    )

    expect(university.errors[:email]).to include("L'email ne peut pas être vide")
  end
end

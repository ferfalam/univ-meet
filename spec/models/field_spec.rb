require 'rails_helper'

RSpec.describe Field, type: :model do
  it "is invalid without name" do
    field = Field.create({
      acronym: "VVV"
    })

    expect(field.errors[:name]).to include("Nom ne peut pas être vide") 
  end

  it "is invalid without acronym" do
    field = Field.create({
      name: "VVV"
    })

    expect(field.errors[:acronym]).to include("Sigle ne peut pas être vide") 
  end
  
end

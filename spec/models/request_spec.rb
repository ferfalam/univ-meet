require 'rails_helper'

RSpec.describe Request, type: :model do
  it "is invalid without title" do
    request = Request.create({
      description: "Some content"
    })
    expect(request.errors[:title]).to  include("Titre ne peut pas être vide")
  end
  
end

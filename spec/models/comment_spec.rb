require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "is invalid without content" do
    comment = Comment.create({
    })

    expect(comment.errors[:context]).to include("Contenue ne peut pas être vide") 
  end
end

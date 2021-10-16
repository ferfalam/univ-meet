require 'rails_helper'

RSpec.describe Post, type: :model do
  it "is invalid without content" do
    post = Post.create({
    })

    expect(post.errors[:content]).to include("Contenue ne peut pas être vide") 
  end
end

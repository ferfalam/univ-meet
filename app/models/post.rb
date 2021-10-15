class Post < ApplicationRecord
    validates :content, presence: true

    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    belongs_to :student
end

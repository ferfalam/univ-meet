class Post < ApplicationRecord
    validates :content, presence: true

    has_many :favorites, dependent: :destroy
    belongs_to :student
end

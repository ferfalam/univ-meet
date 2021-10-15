class Comment < ApplicationRecord
    validates :context, presence: true
    belongs_to :post
    belongs_to :student
end

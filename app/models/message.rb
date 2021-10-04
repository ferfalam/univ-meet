class Message < ApplicationRecord
    validates :content, presence: true

    belongs_to :student
    belongs_to :conversation
end

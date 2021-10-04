class Request < ApplicationRecord
    validates :title, presence: true

    belongs_to :university
end

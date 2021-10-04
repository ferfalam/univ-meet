class Group < ApplicationRecord
    validates :name, presence: true
  
    has_many :group_students_maps, dependent: :destroy
end

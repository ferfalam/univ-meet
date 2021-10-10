class Field < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :acronym, presence: true, uniqueness: true

  belongs_to :university
  has_many :students, dependent: :destroy
end

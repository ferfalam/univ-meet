class University < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true
  validates :acronym, uniqueness: true
  validates :phone_number, uniqueness: true
  validates :email, presence: true, uniqueness: true

  has_many :requests, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :fields, dependent: :destroy
end


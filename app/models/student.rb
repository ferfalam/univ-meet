class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :phone_number, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :card_image, presence: true, uniqueness: true

  has_many :posts, dependent: :nullify
  has_many :messages, dependent: :nullify
  has_many :conversations, dependent: :nullify
  has_many :favorites, dependent: :destroy
  has_many :group_students_maps, dependent: :destroy
  belongs_to :field
  belongs_to :university
end
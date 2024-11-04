class User < ApplicationRecord
  # Devise modules pour l'authentification
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # Associations
  has_many :friendships
  has_many :comments
  has_many :reviews
  has_many :likes

  # Validations
  validates :first_name, :last_name, :username, :email, presence: true
end

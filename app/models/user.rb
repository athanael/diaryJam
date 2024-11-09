class User < ApplicationRecord
  # Devise modules pour l'authentification
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # Associations

  # Validations
  validates :first_name, :last_name, :username, :email, presence: true
end

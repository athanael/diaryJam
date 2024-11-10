class User < ApplicationRecord
  # Devise modules pour l'authentification
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  # Associations

  # Validations
  validates :first_name, :last_name, :username, :email, presence: true

  has_many :tracks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  def is_connected_to_spotify?
    !spotify_id.nil?
  end

  def activity_feed
    posts.includes(:user_track, :comments).order(created_at: :desc)
  end
end

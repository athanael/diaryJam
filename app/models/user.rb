class User < ApplicationRecord
  # Devise modules pour l'authentification
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :tracks, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Gem acts_as_favoritor pour le système de follow
  acts_as_favoritor
  acts_as_favoritable

  # Validations
  validates :first_name, :last_name, :username, :email, presence: true

  def is_connected_to_spotify?
    !spotify_id.nil?
  end

  # Méthode pour savoir si un utilisateur suit un autre utilisateur
  def following?(other_user)
    self.favorited?(other_user)
  end

  # Méthode pour le feed d'activité
  def activity_feed
    posts.includes(:user_track, :comments).order(created_at: :desc)
  end
end

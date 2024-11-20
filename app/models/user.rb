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

  def fetch_user_tracks
    refresh_token if token_expires_at < 5.minutes.from_now

    spotify_user = RSpotify::User.new(
      'id' => spotify_id,
      'credentials' => {
        'token' => spotify_token,
        'refresh_token' => spotify_refresh_token,
        'expires_at' => token_expires_at.to_i
      }
    )

    offset = 0
    loop do
      saved_tracks = spotify_user.saved_tracks(limit: 50, offset: offset)
      saved_tracks.each do |track|
        Track.find_or_create_by(spotify_id: track.id) do |t|
          t.spotify_id = track.id
          t.title = track.name
          t.artist = track.artists.first.name
          t.user = self
        end
      end
      offset += 50
      break if saved_tracks.size < 50
    end
  end

  def refresh_token
    spotify_user = RSpotify::User.new(
      'id' => spotify_id,
      'credentials' => {
        'token' => spotify_token,
        'refresh_token' => spotify_refresh_token,
        'expires_at' => Time.at(token_expires_at)
      }
    )

    spotify_user.to_hash

    update(
      spotify_token: spotify_user.credentials['token'],
      token_expires_at: Time.at(spotify_user.credentials['expires_at'])
    )
  end








end

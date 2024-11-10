class Track < ApplicationRecord
  belongs_to :user

  validates :spotify_id, :title, :artist, presence: true
end

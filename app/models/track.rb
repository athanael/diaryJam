class Track < ApplicationRecord
  belongs_to :user

  validates :spotify_id, presence: true
end

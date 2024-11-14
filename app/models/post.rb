class Post < ApplicationRecord
  belongs_to :user
  belongs_to :track
  has_many :comments, dependent: :destroy

  validates :content, :track_title, :artist_name, presence: true
end

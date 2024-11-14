class Post < ApplicationRecord
  belongs_to :user
  belongs_to :track
  
  validates :content, presence: true, length: { minimum: 3, maximum: 140 }

  has_many :comments, dependent: :destroy

  validates :content, :track_title, :artist_name, presence: true
end

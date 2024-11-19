class Post < ApplicationRecord
  belongs_to :user
  belongs_to :track

  validates :content, presence: true, length: { minimum: 3, maximum: 140 }

  has_many :comments, dependent: :destroy

  scope :recents, -> { order(created_at: :desc).limit(10) }
  scope :followers_posts, -> (followers_id, current_user) { where(user_id: current_user.followers_id).recents }
end

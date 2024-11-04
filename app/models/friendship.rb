class Friendship < ApplicationRecord
  belongs_to :user

  validates :user_id, :friend_id, presence: true
end

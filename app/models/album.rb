class Album < ApplicationRecord
  has_many :tracks
  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  validates :title, :artist, presence: true
end

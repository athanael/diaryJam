class Track < ApplicationRecord
  belongs_to :album
  has_many :reviews, as: :reviewable
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  validates :title, presence: true
end

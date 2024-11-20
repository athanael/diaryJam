class Post < ApplicationRecord
  belongs_to :user
  belongs_to :track

  validates :content, presence: true, length: { minimum: 3, maximum: 140 }

  has_many :comments, dependent: :destroy

  acts_as_favoritable
end

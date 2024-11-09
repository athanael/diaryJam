class Post < ApplicationRecord
  belongs_to :user
  belongs_to :track

  has_many :comments, dependent: :destroy
end

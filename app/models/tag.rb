class Tag < ApplicationRecord
  has_many :tweet_tags, dependent: :destroy
  has_many :tweet, through: :tweet_tags, dependent: :destroy
end

class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, length: { in: 2..50 }
  validates :body, length: { minimum: 2 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end

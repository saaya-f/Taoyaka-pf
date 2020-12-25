class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags, dependent: :destroy

  validates :title, length: { in: 2..25 }
  validates :body, length: { minimum: 2 }
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    title_like(search_params[:title])
      .body_like(search_params[:body])
      .tag_eq(search_params[:tag_id])
  end
  scope :title_like, ->(title){where('title LIKE ?', "%#{title}%") if title.present?}
  scope :body_like, ->(body){where('body LIKE ?', "%#{body}%") if body.present?}
  scope :tag_eq, ->(tag_id) do
    where(tweet_tags: {tag_id: tag_id}) if tag_id.present?
  end
 
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end

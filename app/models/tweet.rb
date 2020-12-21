class Tweet < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, length: { in: 2..25 }
  validates :body, length: { minimum: 2 }
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    title_like(search_params[:title])
      .body_like(search_params[:body])
  end
  scope :title_like, ->(title){where('title LIKE ?', "%#{title}%") if title.present?}
  scope :body_like, ->(body){where('body LIKE ?', "%#{body}%") if body.present?}
 
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end

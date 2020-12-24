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
  end
  scope :title_like, ->(title){where('title LIKE ?', "%#{title}%") if title.present?}
  scope :body_like, ->(body){where('body LIKE ?', "%#{body}%") if body.present?}
 
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # def save_tags(savemicropost_tags)
  #   current_tags = self.tags.pluck(:name) unless self.tags.nil?
  #   old_tags = current_tags - savemicropost_tags
  #   new_tags = savemicropost_tags - current_tags

  #   old_tags.each do |old_name|
  #     self.tags.delete Tag.find_by(name: old_name)
  #   end

  #   new_tags.each do |new_name|
  #     micropost_tag = Tag.find_or_create_by(name: new_name)
  #     self.tags << micropost_tag
  #   end
  # end
end

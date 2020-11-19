class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  attachment :profile_image
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def self.guest
    find_or_create_by!(email: 'guest_uuu@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
end

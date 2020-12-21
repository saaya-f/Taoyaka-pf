class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :validatable, password_length: 6..50

  validates :name, presence: true, length: { in: 2..20 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :age, presence: true, allow_blank: true
  validates :work, presence: true, allow_blank: true
  validates :introduction, presence: true, length: { maximum: 150 }, allow_blank: true

  attachment :profile_image
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships

  enum age: [ "10代", "20代", "30代", "40代", "50代", "60代以上"]
  enum work: ["事務職", "医療・福祉職", "サービス業", "専業主婦", "学生", "その他"]
  
  scope :search, -> (search_params) do
    return if search_params.blank?
    name_like(search_params[:name])
     .age_is(search_params[:age])
     .work_is(search_params[:work])
  end
  scope :name_like, -> (name){where('name LIKE ?', "%#{name}%") if name.present?}
  scope :age_is, -> (age){where(age: age) if age.present?}
  scope :work_is, -> (work){where(work: work) if work.present?}
  
  # ゲストユーザー
  def self.guest
    find_or_create_by!(email: 'guest_ggg@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲスト'
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # ゲストユーザーか、そうでないかの判定
  def guest?
    email == 'guest_ggg@example.com'
  end
  
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end
end

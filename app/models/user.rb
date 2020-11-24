class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :validatable, password_length: 6..50

  validates :name, presence: true, length: { in: 2..25 }
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :age, presence: true, allow_blank: true
  validates :work, presence: true, allow_blank: true
  validates :introduction, presence: true, length: { maximum: 150 }, allow_blank: true

  attachment :profile_image
  has_many :tweets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum age: ["10代", "20代", "30代", "40代", "50代", "60代以上"]
  enum work: ["事務職", "医療・福祉職", "サービス業", "専業主婦", "学生", "その他"]

  # ゲストユーザー
  def self.guest
    find_or_create_by!(email: 'guest_ggg@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
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
end

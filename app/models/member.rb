class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :introduction,    length: { maximum: 60 }
  validates :name, presence: true, length: { maximum: 10}

  attachment :image


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :playing_games, dependent: :destroy
  has_many :games, through: :playing_games

  has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_user, through: :following, source: :follower
  has_many :follower_user, through: :follower, source: :following

  has_many :entries
  has_many :chats
  has_many :rooms, through: :entries

  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  def follow(user_id)
    following.create(follower_id: user_id)
  end

  def unfollow(user_id)
    following.find_by(follower_id: user_id).destroy
  end

  def following?(user_id)
    following_user.include?(user_id)
  end
  
  # フォロー通知
  def create_notification_follow!(current_member)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_member.id, id, 'follow'])
    if temp.blank?
      notification = current_member.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  # 部分一致で検索
  def self.search(search)
    if search
      where("name LIKE ?","%#{search}%")
    else
      all
    end
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
      member.password = SecureRandom.urlsafe_base64
      member.name = "ゲストユーザー"
    end
  end



end

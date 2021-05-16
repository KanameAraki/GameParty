class Post < ApplicationRecord

 validates :content, presence: true, length: {maximum:150}

  belongs_to :member
  belongs_to :game, optional: true

   enum category:{
    normal:      0,
    recruitment: 1,
    closed:      2,
  }

  has_many :comments

  has_many :favorites
  has_many :members, through: :favorites

  def favorited_by?(member)
   favorites.where(member_id: member.id).exists?
  end

 has_many :notifications, dependent: :destroy


 #ログイン中のメンバーが通知を作成
 def create_notification_by(current_member)
   notification = current_member.active_notifications.new(
     post_id: id,
     visited_id: member_id,
     action: "favorite"
   )
   if notification.valid?
    notification.save
   end
 end

 def create_notification_comment!(current_member, comment_id)
   # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
   temp_ids = Comment.select(:member_id).where(post_id: id).where.not(member_id: current_member.id).distinct
   temp_ids.each do |temp_id|
       save_notification_comment!(current_member, comment_id, temp_id['member_id'])
   end
   # binding.pry
   # まだ誰もコメントしていない場合は、投稿者に通知を送る
   save_notification_comment!(current_member, comment_id, member_id) if temp_ids.blank?
 end

 def save_notification_comment!(current_member, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_member.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # binding.pry
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
 end

end

class Public::NotificationsController < ApplicationController

  def index
      #current_userの投稿に紐づいた通知一覧
        @notifications = current_member.passive_notifications

        # @notifications.each do |notice|
        #   @member = Member.find(notice.visiter_id)
        #   if notice.post_id != nil
        #     @post = Post.find(notice.post_id)
        #   end
        # end
      #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
        @notifications.where(checked: false).each do |notification|
            notification.update_attributes(checked: true)
        end
  end

  def destroy_all
    #通知を全削除
      @notifications = current_member.passive_notifications.destroy_all
      redirect_to notifications_path
  end

end

class Public::NotificationsController < ApplicationController

  before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def index
    #current_memberの投稿に紐づいた通知一覧
    @notifications = current_member.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end

end

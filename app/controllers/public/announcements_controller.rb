class Public::AnnouncementsController < ApplicationController

  before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def index
    @announcements = Announcement.all.order(created_at: :DESC)
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

end

class Public::AnnouncementsController < ApplicationController

  def index
    @announcements = Announcement.all.order(created_at: :DESC)
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

end

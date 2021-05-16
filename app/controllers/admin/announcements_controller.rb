class Admin::AnnouncementsController < ApplicationController
  
  before_action :authenticate_admin!

  def new
    @announcement = Announcement.new
  end

  def create
    announcement = Announcement.new(announcement_params)
    if announcement.save
      redirect_to root_path
    else
      @announcement = announcement
      render "new"
    end
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title,:body)
  end

end

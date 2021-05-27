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

  def edit
    @announcement = Announcement.find(params[:id])
  end
  
  def update
    announcement = Announcement.find(params[:id])
    announcement.update(announcement_params)
    redirect_to announcement_path(announcement)
  end

  def destroy
    announcement = Announcement.find(params[:id])
    announcement.destroy
    redirect_to announcements_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title,:body)
  end

end

class Admin::AnnouncementsController < ApplicationController

  def show
    @announcement = Announcement.find(params[:id])
    @body = @announcement.body
  end

  def new
    @announcement = Announcement.new
  end

  def create
    announcement = Announcement.new(announcement_params)
    announcement.save
    redirect_to root_path
  end

  private

  def announcement_params
    params.require(:announcement).permit(:title,:body)
  end

end

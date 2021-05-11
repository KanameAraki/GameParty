class Public::HomesController < ApplicationController

  def top
    @announcements = Announcement.all
  end

  def about
  end

end

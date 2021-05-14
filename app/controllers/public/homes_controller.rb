class Public::HomesController < ApplicationController

  def top
    @announcements = Announcement.all.order(created_at: :DESC)
  end

  def about
  end

end

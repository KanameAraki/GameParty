class Admin::MembersController < ApplicationController
  
  before_action :authenticate_admin!

  def index
    if params[:search]
      @members = Member.search(params[:search])
      # binding.pry
    else
      @members = Member.all
    end
  end

  def close
    member = Member.find(params[:member_id])
    # binding.pry
    if member.is_deleted?
      member.update(is_deleted: false)
      redirect_back(fallback_location: root_path)
    else
      member.update(is_deleted: true)
      redirect_back(fallback_location: root_path)
    end
  end

end

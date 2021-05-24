class Admin::MembersController < ApplicationController

  before_action :authenticate_admin!

  def index
    if params[:search]
      @members = Member.search(params[:search])
    else
      @members = Member.all
    end
  end

# 管理者がメンバーのログイン権限を剥奪
  def close
    member = Member.find(params[:member_id])
    if member.is_deleted?
      member.update(is_deleted: false)
      redirect_back(fallback_location: root_path)
    else
      member.update(is_deleted: true)
      redirect_back(fallback_location: root_path)
    end
  end

end

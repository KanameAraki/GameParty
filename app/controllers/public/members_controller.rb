class Public::MembersController < ApplicationController

  before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def show
    @member = Member.find(params[:id])
    @playing_games = @member.games.order(created_at: :DESC)
    @posts = @member.posts.order(created_at: :DESC)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    member = Member.find(params[:id])
    if member.update(member_params)
      redirect_to member_path(current_member)
    else
      @member = member
      render "edit"
    end
  end


private

def member_params
  params.require(:member).permit(:name,:image,:introduction)
end


end

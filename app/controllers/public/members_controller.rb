class Public::MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
    @playing_games = @member.games.order(created_at: :DESC)
    @posts = @member.posts.order(created_at: :DESC)
  end

  def edit
    # @member = Member.find(params[:id])
  end

  def update
    member = Member.find(params[:id])
    member.update(member_params)
    redirect_to member_path(current_member)
  end

private

def member_params
  params.require(:member).permit(:name,:image,:introduction)
end


end

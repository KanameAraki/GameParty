class Public::PlayingGamesController < ApplicationController

  before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def index
    @member = Member.find(params[:member_id])
  end

  def create
    playing_game = PlayingGame.new
    playing_game.member_id = params[:member_id]
    playing_game.game_id = params[:game_id]
    playing_game.save
    redirect_to request.referer
  end

  def destroy
    playing_game = PlayingGame.find_by(member_id: params[:member_id],game_id: params[:game_id])
    playing_game.destroy
    redirect_to request.referer
  end

  def playing_game_params
    params.require(:playing_game).permit(:member_id,:game_id)
  end

end

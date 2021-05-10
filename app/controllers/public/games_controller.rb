class Public::GamesController < ApplicationController

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
    @posts = Post.where(game_id: @game.id)
  end

end

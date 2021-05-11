class Public::GamesController < ApplicationController

  def index
    if params[:search]
      @games = Game.search(params[:search])
      # binding.pry
    else
      @games = Game.all
    end
  end

  def show
    @game = Game.find(params[:id])
    if params[:search] == "1"
    @posts = Post.where(game_id: @game.id, category: "recruitment")
    else
    @posts = Post.where(game_id: @game.id)
    end
    # binding.pry
  end
end

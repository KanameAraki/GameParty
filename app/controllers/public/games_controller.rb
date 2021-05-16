class Public::GamesController < ApplicationController

    before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

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
    @posts = Post.where(game_id: @game.id, category: "recruitment").order(created_at: :DESC)
    else
    @posts = Post.where(game_id: @game.id).order(created_at: :DESC)
    end
    # binding.pry
  end

end

class Admin::GamesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @games = Game.all
    if params[:search]
      @games = Game.search(params[:search])
      @famous_games = Game.find(PlayingGame.group(:game_id).order("count(game_id) desc").limit(5).pluck(:game_id))
    else
    #ゲーム人気ランキング
      @famous_games = Game.find(PlayingGame.group(:game_id).order("count(game_id) desc").limit(5).pluck(:game_id))
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    game = Game.new(game_params)
    if game.save
      redirect_to admin_games_path
    else
      @game = game
      render "new"
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    game = Game.find(params[:id])
    game.update(game_params)
    redirect_to admin_games_path
  end

  def destroy
    game = Game.find(params[:id])
    game.destroy
    redirect_to admin_games_path
  end

  private

  def game_params
    params.require(:game).permit(:name,:introduction,:image)
  end

end

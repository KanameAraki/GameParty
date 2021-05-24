class Public::GamesController < ApplicationController

    before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def index
    @games = Game.all
    #ゲーム検索
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
    # :searchに1が送られてきたら募集投稿のみ返す
    if params[:search] == "1"
     @posts = Post.where(game_id: @game.id, category: "recruitment").order(created_at: :DESC)
    else
      @posts = Post.where(game_id: @game.id).order(created_at: :DESC)
    end
  end

end

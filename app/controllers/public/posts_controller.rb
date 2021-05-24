class Public::PostsController < ApplicationController

  before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def new
    @new_post = Post.new
    playing_games = current_member.playing_games
    game_ids = playing_games.pluck(:game_id)
    @games = Game.where(id: game_ids)
  end

  def index
    #左側本人情報
    @member = current_member
    @playing_games = @member.games.order(created_at: :DESC)
    # 右側フォローした人の投稿
    members = @member.follower_user
    # binding.pry
    @posts = Post.where(member_id: members.ids).or( Post.where(member_id: current_member.id)).order(created_at: :DESC)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @not_replies = @comments.where(reply: nil)
    @new_comment = Comment.new
    @reply = Comment.new
  end

  def create
    new_post = Post.new(post_params)
    new_post.member_id = current_member.id
    if new_post.save
      redirect_to member_path(current_member)
    else
       @new_post = new_post
       playing_games = current_member.playing_games
        game_ids = playing_games.pluck(:game_id)
        @games = Game.where(id: game_ids)
      render "new"
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end
  # 募集投稿の締め切り
  def close
    post = Post.find(params[:post_id])
    post.category = 2
    post.save
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content,:category,:member_id,:game_id)
  end

end

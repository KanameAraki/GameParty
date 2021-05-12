class Public::PostsController < ApplicationController

  def new
    @new_post = Post.new
    playing_games = current_member.playing_games
    game_ids = playing_games.pluck(:game_id)
    @games = Game.where(id: game_ids)
  end

  def index
  # 　左側本人情報
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
    @new_comment = Comment.new
    @reply = Comment.new
  end

  def create
    new_post = Post.new(post_params)
    new_post.member_id = current_member.id
    new_post.save
    # 通知を作成
    @item = Post.find(params[:post_id])
    @item.create_notification_by(current_member)
    redirect_to member_path(current_member)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  def close
    post = Post.find(params[:post_id])
    p post
    post.category = 2
    p post
    post.save
    redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:content,:category,:member_id,:game_id)
  end

end

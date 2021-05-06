class Public::PostsController < ApplicationController

  def index
    @new_post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    new_post = Post.new(post_params)
    new_post.member_id = current_member.id
    new_post.save
    redirect_to member_path(current_member)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:content,:category)
  end

end

class Public::FavoritesController < ApplicationController

  def create
    member = current_member
    @post = Post.find(params[:post_id])
    Favorite.create(member_id: member.id,post_id: @post.id)
  end

  def destroy
    member = current_member
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(member_id: member.id, post_id: @post.id)
    favorite.destroy
  end

end

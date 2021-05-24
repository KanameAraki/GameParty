class Public::FavoritesController < ApplicationController

  def create
    member = current_member
    @post = Post.find(params[:post_id])
    Favorite.create(member_id: member.id,post_id: @post.id)
    # 自分に対するいいねじゃなければ通知を作成
   if @post.member != member
    @post.create_notification_by(current_member)
   end
  end

  def destroy
    member = current_member
    @post = Post.find(params[:post_id])
    favorite = Favorite.find_by(member_id: member.id, post_id: @post.id)
    favorite.destroy
  end

end

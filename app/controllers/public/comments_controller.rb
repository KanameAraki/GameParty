class Public::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.member_id = current_member.id
    comment.post_id = post.id
    @comment_post = comment.post
    if comment.save
      @comment_post.create_notification_comment!(current_member, comment.id)
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:member_id,:post_id,:reply)
  end

end

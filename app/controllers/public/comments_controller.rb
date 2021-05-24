class Public::CommentsController < ApplicationController

    before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def create
    post = Post.find(params[:post_id])
    comment = Comment.new(comment_params)
    comment.member_id = current_member.id
    comment.post_id = post.id
    # 通知の作成
    if comment.save
      post.create_notification_comment!(current_member, comment.id)
      @post = post
      @comments = @post.comments
      @not_replies = @comments.where(reply: nil)
      @empty_comment = comment
      @new_comment = Comment.new
      @reply = Comment.new
      render "public/posts/show"
    else
      @post = post
      @comments = @post.comments
      @not_replies = @comments.where(reply: nil)
      @empty_comment = comment
      @new_comment = Comment.new
      @reply = Comment.new
      render "public/posts/show"
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @not_replies = @comments.where(reply: nil)
    @empty_comment = comment
    @new_comment = Comment.new
    @reply = Comment.new
    render "public/posts/show"
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:member_id,:post_id,:reply)
  end

end

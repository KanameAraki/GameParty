class Public::PostsController < ApplicationController

  def index
    @new_post = Post.new
    @posts = Post.all


    @playing_games = current_member.playing_games #メンバーが「プレイ中のゲーム」に追加したゲーム一覧を出したい
    game_ids = @playing_games.pluck(:game_id)     #playing_gamesテーブルからgame_idを抜き取る
    @games = Game.where(id: game_ids)            #game_idに該当するデータを配列で得る、.namesで名前が出ると思ったがでない
    # @names = games.pluck(:name)                   #名前だけ抜き取るが、（おそらく）idがないことが原因でエラーが出る
    #名前を配列で得ることはできたが、配列から名前を得ることができない？

    # binding.pry


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
    redirect_to member_path(current_member)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
  end

  private

  def post_params
    params.require(:post).permit(:content,:category,:member_id,:game_id)
  end

end

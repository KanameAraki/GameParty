class Batch::DataGuest

  # guestmemberの投稿を削除
  def self.data_reset
    member = Member.find_by(email: "guest@example.com")
    member.posts.destroy_all
    member.comments.destroy_all
  end
end
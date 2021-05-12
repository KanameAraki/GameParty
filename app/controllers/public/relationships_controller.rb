class Public::RelationshipsController < ApplicationController

  def followings
    @member = Member.find(params[:member_id])
  end

  def followers
    @member = Member.find(params[:member_id])
  end

  def create
    follow = Relationship.new
    follow.follower_id = current_member.id
    follow.following_id = Member.find(params[:member_id]).id
    follow.save
    redirect_back(fallback_location: root_path)

    @member = Member.find(params[:member_id])
    @member.create_notification_follow!(current_member)
  end

  def destroy
    member = Member.find(params[:member_id])
    follow = Relationship.find_by(follower_id: current_member,following_id: member.id)
    follow.destroy
    redirect_back(fallback_location: root_path)
  end

end

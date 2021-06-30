class Public::ChatsController < ApplicationController

  before_action :authenticate_member!
  skip_before_action :authenticate_member!,if: :admin_signed_in?

  def show
    @member = Member.find(params[:id])
    # ログインメンバーが参加しているRoomのidを取得
    rooms = current_member.entries.pluck(:room_id)
    # 相手のメンバーが同じRoomに参加していないか探す
    entries = Entry.find_by(member_id: @member.id, room_id: rooms)
    # 該当するEntryがなければRoom、Entryを新しく作成
    if entries.nil?
      @room = Room.new
      @room.save
      Entry.create(member_id: @member.id, room_id: @room.id)
      Entry.create(member_id: current_member.id, room_id: @room.id)
    else
      @room = entries.room
    end
    # Chatの表示と新規作成
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_member.chats.new(chat_params)
    if @chat.save
      @room = @chat.room
      @friend_entry = Entry.where(room_id: @room.id).where.not(member_id: current_member.id)
      @theid = @friend_entry.find_by(room_id: @room.id)
      # 通知を作成
      notification = current_member.active_notifications.new(
        room_id: @room.id,
        chat_id: @chat.id,
        visited_id: @theid.member_id,
        visiter_id: current_member.id,
        action: 'dm'
        )
      # 自分への通知はなくす
      if notification.visiter_id == notification.visited_id
          notification.checked = true
      end

      if notification.valid?
        notification.save
        redirect_back(fallback_location: root_path)
      end
      
      else
        
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message,:room_id)
  end

end

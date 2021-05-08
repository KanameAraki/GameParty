class Public::ChatsController < ApplicationController

  def show
    @member = Member.find(params[:id])
    rooms = current_member.entries.pluck(:room_id)
    entries = Entry.find_by(member_id: @member.id, room_id: rooms)

    if entries.nil?
      @room = Room.new
      @room.save
      Entry.create(member_id: @member.id, room_id: @room.id)
      Entry.create(member_id: current_member.id, room_id: @room.id)
    else
      @room = entries.room
    end

    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_member.chats.new(chat_params)
    @chat.save
  end

  private

  def chat_params
    params.require(:chat).permit(:message,:room_id)
  end

end

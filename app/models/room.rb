class Room < ApplicationRecord

  has_many :chats
  has_many :entries

  has_many :notifications, dependent: :destroy

end

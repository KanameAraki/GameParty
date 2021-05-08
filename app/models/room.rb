class Room < ApplicationRecord

  has_many :chats
  has_many :entries

end

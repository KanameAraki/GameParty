class Chat < ApplicationRecord

  belongs_to :member
  belongs_to :room

  has_many :notifications, dependent: :destroy

end

class Comment < ApplicationRecord

  belongs_to :member
  belongs_to :post

  belongs_to :parent, class_name: "Comment", optional: true
  has_many :replies, class_name: "Comment", foreign_key: :reply, dependent: :destroy

end

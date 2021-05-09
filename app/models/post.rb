class Post < ApplicationRecord

  belongs_to :member
  belongs_to :game, optional: true

   enum category:{
    normal:      0,
    recruitment: 1,
    closed:      2,
  }

  has_many :comments
  
  has_many :favorites
  has_many :members, through: :favorites
  
  def favorited_by?(member)
   favorites.where(member_id: member.id).exists?
  end

 

end

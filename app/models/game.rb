class Game < ApplicationRecord

   validates :name, presence: true
   validates :introduction,presence: true, length: {maximum:150}

  has_many :posts, dependent: :destroy
  has_many :playing_games, dependent: :destroy
  has_many :members, through: :playing_games

  attachment :image

  def self.search(search)
    if search
      where("name LIKE ?","%#{search}%")
    else
      all
    end
  end

end

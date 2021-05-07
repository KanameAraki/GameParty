class Game < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :playing_games, dependent: :destroy
  has_many :members, through: :playing_games

  attachment :image

end

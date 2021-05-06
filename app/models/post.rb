class Post < ApplicationRecord

  belongs_to :member
  belongs_to :game, optional: true

   enum category:{
    normal:      0,
    recruitment: 1,
    closed:      2,
  }

end

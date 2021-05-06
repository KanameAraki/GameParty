class Post < ApplicationRecord

  belongs_to :member

   enum category:{
    normal:      0,
    recruitment: 1,
    closed:      2,
  }

end

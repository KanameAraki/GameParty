class Contact < ApplicationRecord

  validates :name, presence: true
  validates :email, presence: true
  validates :body, presence: true

  enum subject:{
    other:   0,
    request: 1,
    report:  2,
  }

end

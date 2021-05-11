class Contact < ApplicationRecord

  enum subject:{
    other:   0,
    request: 1,
    report:  2,
  }

end

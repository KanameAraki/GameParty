class Notification < ApplicationRecord

   default_scope->{order(created_at: :desc)}

    belongs_to :post, optional: true
    belongs_to :comment, optional: true
    belongs_to :visiter, class_name: 'Member', foreign_key: 'visiter_id', optional: true
    belongs_to :visited, class_name: 'Member', foreign_key: 'visited_id', optional: true

    belongs_to :room, optional: true
    belongs_to :chat, optional: true



end

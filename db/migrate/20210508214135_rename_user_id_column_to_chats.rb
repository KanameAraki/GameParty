class RenameUserIdColumnToChats < ActiveRecord::Migration[5.2]
  def change
    rename_column :chats, :user_id, :member_id
  end
end

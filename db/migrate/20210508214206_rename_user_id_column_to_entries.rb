class RenameUserIdColumnToEntries < ActiveRecord::Migration[5.2]
  def change
    rename_column :entries, :user_id, :member_id
  end
end

class RenameParentIdColumnToReply < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :parent_id, :reply
  end
end

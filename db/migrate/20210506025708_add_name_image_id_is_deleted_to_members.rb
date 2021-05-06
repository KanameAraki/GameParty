class AddNameImageIdIsDeletedToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :name, :string, null: false, default: ""
    add_column :members, :image_id, :string
    add_column :members, :is_deleted, :boolean, null: false, default: false
  end
end

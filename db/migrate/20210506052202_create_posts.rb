class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :content, null: false, default: ""
      t.integer :category, null: false, default: 0

      t.timestamps
    end
  end
end

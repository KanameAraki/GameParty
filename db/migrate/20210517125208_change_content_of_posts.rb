class ChangeContentOfPosts < ActiveRecord::Migration[5.2]
  def change

    def up
      change_column :posts, :content, :text
    end

    def down
      change_column :posts, :content, :text, default: ""
    end
  end
end

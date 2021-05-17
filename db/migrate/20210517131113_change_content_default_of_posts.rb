class ChangeContentDefaultOfPosts < ActiveRecord::Migration[5.2]
  def change
    def up
      change_column_default :posts, :content, nil
    end

    def down
      change_column_default :posts, :content, ""
    end
  end
end

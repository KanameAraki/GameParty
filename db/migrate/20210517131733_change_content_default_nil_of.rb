class ChangeContentDefaultNilOf < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:posts,:content,nil)
  end
end

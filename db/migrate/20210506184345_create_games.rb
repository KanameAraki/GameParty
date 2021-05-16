class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name, default: "", null: false
      t.text :introduction
      t.string :image_id

      t.timestamps
    end
  end
end

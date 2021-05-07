class CreatePlayingGames < ActiveRecord::Migration[5.2]
  def change
    create_table :playing_games do |t|
      t.integer :member_id
      t.integer :game_id

      t.timestamps
    end
  end
end

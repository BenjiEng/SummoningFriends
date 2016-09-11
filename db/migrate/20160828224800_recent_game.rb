class RecentGame < ActiveRecord::Migration
  def change
    create_table :recent_games do |t|
      t.integer "champion_id"
      t.string "create_date"
      t.text "fellow_players"
      t.string "game_id"
      t.string "game_mode"
      t.string "game_type"
      t.boolean "invalid"
      t.integer "map_id"
      t.integer "spell_1"
      t.integer "spell_2"
      t.text "stats"
      t.integer "team_id"
      t.integer "friend_id", null: false
    end
  end
end

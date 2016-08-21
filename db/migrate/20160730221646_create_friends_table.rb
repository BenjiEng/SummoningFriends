class CreateFriendsTable < ActiveRecord::Migration
  def change
    create_table :friends do |t|
        t.string "summoner_id", null: false
        t.string "summoner_name", null: false
        t.string "summoner_icon_id"
        t.string "revision_date"
        t.string "summoner_level"
        t.integer "user_id", null: false
        t.timestamps null: false
    end
  end
end

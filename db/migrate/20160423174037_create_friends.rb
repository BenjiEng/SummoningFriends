class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer "summoner_id", null: false
      t.string "summoner_name", null: false
      t.integer "summoner_icon_id"
      t.integer "revision_date"
      t.integer "summoner_level"
      t.integer "user_id", null: false
      t.timestamps null: false
    end
  end
end

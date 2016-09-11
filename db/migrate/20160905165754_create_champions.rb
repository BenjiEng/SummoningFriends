class CreateChampions < ActiveRecord::Migration
  def change
    create_table :champions do |t|
      t.integer "key", null: false
      t.string "name"
      t.string "title"
      t.text "blurb"
      t.text "image"
    end
  end
end

class ChampionsController < ApplicationController
  include HTTParty

  # t.integer "key",   null: false
  # t.string  "name"
  # t.string  "title"
  # t.text    "blurb"
  # t.text    "image"

  def create
      Champion.delete_all
      response = HTTParty.get('https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?api_key=5e9b0f51-4139-4c8a-bc4d-864cdefae73f')
      champions = response["data"]
      champions.each do |champion|
        champ_hash = champion[1]

        @new_champion = Champion.new
        @new_champion.key = champ_hash["id"]
        @new_champion.name = champ_hash["key"]
        @new_champion.title = champ_hash["title"]
        @new_champion.save
      end
      render :json => "SUCCESS"
  end

end

class GamesController < ApplicationController

  # t.integer "champion_id"
  # t.string  "create_date"
  # t.text    "fellow_players"
  # t.string  "game_id"
  # t.string  "game_mode"
  # t.string  "game_type"
  # t.integer "map_id"
  # t.integer "spell_1"
  # t.integer "spell_2"
  # t.text    "stats"
  # t.integer "team_id"
  # t.integer "friend_id",      null: false

  def create
    summoner_id = params[:summoner_id]
    friend_id = params[:friend_id]
    url = "https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{summoner_id}/recent?api_key=5e9b0f51-4139-4c8a-bc4d-864cdefae73f"
    response = HTTParty.get(url)
    last_game = response["games"][0]

    @game = Game.new
    @game.champion_id = last_game["champion_id"]
    @game.create_date = last_game["createDate"]
    @game.fellow_players = last_game["fellowPlayers"]
    @game.game_id = last_game["gameId"]
    @game.game_mode = last_game["gameMode"]
    @game.game_type = last_game["gameType"]
    @game.map_id = last_game["mapId"]
    @game.spell_1 = last_game["spell1"]
    @game.spell_2 = last_game["spell2"]
    @game.stats = last_game["stats"]
    @game.team_id = last_game["teamId"]
    @game.friend_id = friend_id

    @game.save
  end

  private

  def recent_game_params
    params.require(:recent_game).permit(:champion_id, :create_date, :fellow_players, :game_id, :game_mode, :game_type, :map_id, :spell_1, :spell_2, :stats, :team_id, :friend_id)
  end

end

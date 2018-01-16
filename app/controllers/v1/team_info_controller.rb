class V1::TeamInfoController < ApplicationController

  def index
    team_name = Team.find_by(id: params[:team_id]).name

    response = Unirest.get("http://thesportsdb.com/api/v1/json/#{ENV['SPORTSDB_API_KEY']}/searchteams.php?t=#{team_name}")

    api_team_id = response.body["teams"][0]["idTeam"]
    league_id = response.body["teams"][0]["idLeague"]
    
    results = Unirest.get("http://www.thesportsdb.com/api/v1/json/#{ENV['SPORTSDB_API_KEY']}/eventslast.php?id=#{api_team_id}")
    # render json: results.body
    # render json: {stuff: response.body, other_stuff: results.body}

    next_five = Unirest.get("http://www.thesportsdb.com/api/v1/json/#{ENV['SPORTSDB_API_KEY']}/eventsnext.php?id=#{api_team_id}")

    standings = Unirest.get("http://www.thesportsdb.com/api/v1/json/#{ENV['SPORTSDB_API_KEY']}/lookuptable.php?l=#{league_id}&s=1718")

    render json: {team_info: response.body, recent_results: results.body, schedule: next_five.body, standings: standings.body}
  end
end

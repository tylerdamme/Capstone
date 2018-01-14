class V1::TeamInfoController < ApplicationController

  def index
    puts "hello"
    team_name = Team.find_by(id: params[:team_id]).name
    puts "goodbye"

    response = Unirest.get("http://thesportsdb.com/api/v1/json/#{ENV['SPORTSDB_API_KEY']}/searchteams.php?t=#{team_name}")

    render json: response.body
  end
end

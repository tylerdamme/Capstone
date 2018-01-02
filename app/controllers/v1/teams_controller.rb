class V1::TeamsController < ApplicationController
  
  def index
    teams = current_user.teams
    render json: teams.as_json
  end

  def show
    team = Team.find_by(id: params[:id])
    render json: team.as_json
  end
end


class V1::UserTeamsController < ApplicationController
  before_action :authenticate_user

  def create
    user_team = UserTeam.new(
      user_id: current_user.id,
      team_id: params[:team_id]
      )
    if user_team.save
      render json: {message: user_team.as_json}
    else
      render json: {errors: user_team.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    puts "hello"
    user_team = UserTeam.find_by(
      team_id: params[:team_id],
      user_id: current_user.id)
    puts "#{user_team}"
    if user_team
      user_team.destroy
      render json: {message: "team successfully removed"}
    else
      render json: {message: "team has not been removed"}
    end
  end
end

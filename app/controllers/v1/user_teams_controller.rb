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
end

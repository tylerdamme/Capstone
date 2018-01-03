class NewsSourcesController < ApplicationController
  
  def create
    news_source = NewsSource.new(
      api_name: params[:api_name],
      display_name: params[:display_name],
      team_id: current_team.id,
      user_id: current_user.id
      )

    if news_source.save
      render json: news_source.as_json
    else
      render json: {errors: news_source.errors.full_messages}, status: :bad_request
    end
  end
end

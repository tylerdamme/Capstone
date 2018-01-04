class V1::NewsSourcesController < ApplicationController
  # before_action :authenticate_user
  def create
    news_source = NewsSource.find_by(api_name: params[:api_name], user_id: current_user.id, team_id: params[:team_id])
    if news_source
      render json: {message: "news source already exists"}
    else
      news_source = NewsSource.new(
        api_name: params[:api_name],
        display_name: params[:display_name],
        team_id: params[:team_id],
        user_id: current_user.id
        )

      if news_source.save
        render json: news_source.as_json
      else
        render json: {errors: news_source.errors.full_messages}, status: :bad_request
      end
    end
  end

  def destroy_by_name
    news_source = NewsSource.find_by(api_name: params[:api_name], user_id: current_user.id, team_id: params[:team_id])
    if news_source
      news_source.destroy
      render json: {message: "news source successfully destroyed"}
    else
      render json: {message: "team does not exist"}
    end
  end

end

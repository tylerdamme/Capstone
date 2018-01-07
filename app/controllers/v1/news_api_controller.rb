class V1::NewsApiController < ApplicationController
  def index

    news_sources = NewsSource.where(user_id: current_user.id, team_id: params[:team_id]) 
    sources = news_sources.map { |news_source| news_source.api_name }.join(",")

    team_name = Team.find_by(id: params[:team_id]).name

    response = Unirest.get("https://newsapi.org/v2/everything?sources=#{sources}&q=#{team_name}&apiKey=#{ENV['NEWS_API_KEY']}")
    render json: response.body
  end
end

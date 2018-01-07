class Team < ApplicationRecord
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :news_sources

  # def search
  #   search_terms = Team.name
  #   sources = User.teams.news_sources.map { |news_source| news_source.api_name }.join(",")

  #   response = Unirest.get("https://newsapi.org/v2/everything?sources=#{sources}&q=#{search_terms}&apiKey=#{ENV['NEWS_API_KEY']}")
  #   render json: response.body
  # end

  def as_json
    {
      id: id,
      name: name,
      # news_sources: search
    }
  end
end

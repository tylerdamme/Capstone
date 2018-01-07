class NewsSource < ApplicationRecord
  belongs_to :team

  # def search
  #   search_terms = team.name
  #   sources = current_user.news_sources.map { |news_source| news_source.api_name }.join(",")

  #   response = Unirest.get("https://newsapi.org/v2/everything?sources=#{sources}&q=#{search_terms}&apiKey=#{ENV['NEWS_API_KEY']}")
  #   render json: response.body
  # end

  # def as_json
  #   {
  #   display_name: display_name,
  #   # search: search
  #   }

  # end
end

class Team < ApplicationRecord
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :news_sources

  def as_json
    {
      id: id,
      name: name,
      news_sources: news_sources.map { |news_source| news_source.display_name }
    }
  end
end

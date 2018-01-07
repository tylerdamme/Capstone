class User < ApplicationRecord
  has_many :user_teams
  has_many :news_sources
  has_many :teams, through: :user_teams
  has_secure_password

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true
  def as_json
    {
      id: id,
      name: name,
      teams: teams.as_json
    }
  end
end

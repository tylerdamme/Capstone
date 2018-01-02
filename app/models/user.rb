class User < ApplicationRecord
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_secure_password

  def as_json
    {
      id: id,
      name: name,
      teams: teams.as_json
    }
  end
end

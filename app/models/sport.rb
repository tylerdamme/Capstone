class Sport < ApplicationRecord
  has_many :teams

  def as_json
    {
      id: id,
      name: name,
      teams: teams.order(:name => :asc).as_json
    }
  end
end

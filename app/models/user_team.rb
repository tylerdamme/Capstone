class UserTeam < ApplicationRecord
  belongs_to :User
  belongs_to :team
end

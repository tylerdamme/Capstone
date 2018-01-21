class AddSportIdtoTeams < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :sport_id, :integer
  end
end

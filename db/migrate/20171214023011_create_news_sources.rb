class CreateNewsSources < ActiveRecord::Migration[5.1]
  def change
    create_table :news_sources do |t|
      t.string :api_name
      t.string :display_name
      t.integer :team_id

      t.timestamps
    end
  end
end

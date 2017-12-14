class AddUserIDtoNewsSource < ActiveRecord::Migration[5.1]
  def change
    add_column :news_sources, :user_id, :integer
  end
end

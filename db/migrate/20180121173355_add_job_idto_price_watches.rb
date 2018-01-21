class AddJobIdtoPriceWatches < ActiveRecord::Migration[5.1]
  def change
    add_column :price_watches, :job_id, :string
  end
end

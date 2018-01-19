class CreatePriceWatches < ActiveRecord::Migration[5.1]
  def change
    create_table :price_watches do |t|
      t.integer :user_id
      t.string :ticketmaster_id
      t.string :event_id
      t.integer :form_input

      t.timestamps
    end
  end
end

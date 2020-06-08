class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.string :event_id
      t.string :restaurant_id

      t.timestamps
    end
  end
end

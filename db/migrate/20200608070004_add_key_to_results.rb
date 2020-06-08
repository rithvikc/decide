class AddKeyToResults < ActiveRecord::Migration[6.0]
  def change
    remove_column :results, :event_id
    remove_column :results, :restaurant_id
    add_reference :results, :event, null: false, foreign_key: true
    add_reference :results, :restaurant, null: false, foreign_key: true
  end
end

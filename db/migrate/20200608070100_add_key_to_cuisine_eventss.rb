class AddKeyToCuisineEventss < ActiveRecord::Migration[6.0]
  def change
    remove_column :cuisine_events, :event_id
    remove_column :cuisine_events, :cuisine_id
    add_reference :cuisine_events, :event, null: false, foreign_key: true
    add_reference :cuisine_events, :cuisine, null: false, foreign_key: true
  end
end

class AddDetailsToCuisineEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :cuisine_events, :event_id, :string
    add_column :cuisine_events, :cuisine_id, :string
  end
end

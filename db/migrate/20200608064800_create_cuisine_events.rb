class CreateCuisineEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :cuisine_events do |t|

      t.timestamps
    end
  end
end

class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :yelp_id
      t.string :name
      t.string :description
      t.string :location

      t.timestamps
    end
  end
end

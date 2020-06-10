class AddRatingsToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :ratings, :float
  end
end

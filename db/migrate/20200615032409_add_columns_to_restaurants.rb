class AddColumnsToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :image_url, :string
    add_column :restaurants, :price, :integer
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
  end
end

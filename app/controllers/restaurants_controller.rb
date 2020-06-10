class RestaurantsController < ApplicationController

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.save!
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:yelp_id, :name, :description, :location, :rating)
  end
end

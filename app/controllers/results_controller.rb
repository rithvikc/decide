class ResultsController < ApplicationController
  require 'json'
  require 'open-uri'
  require "uri"
  require 'net/http'

  def show
    @result = Result.find(params[:id])
  end

  def create
    @result = Result.new(result_params)
    @event = Event.find(params[:event_id])
    yelp_cuisine_logic
    yelp_location_logic
    yelp_api_call(@geo_center, @most_frequent_cuisine)
    @restaurant = Restaurant.last
    @result.restaurant = @restaurant
    @result.event = @event
    @result.save!
    redirect_to event_result_path(@event, @result)
  end

  def restaurant_create
    @restaurant = Restaurant.new(restaurant_params)
  end

  def yelp_cuisine_logic
    # counts the user selection of cuisines and returns the most picked cuisine
    cuisine_array = []
    @event.invitations.each do |i|
      cuisine_array << i.cuisine.name
    end
    @most_frequent_cuisine = cuisine_array.max_by { |i| cuisine_array.count(i) }
  end

  def yelp_location_logic
    # accept an an array of hashes of user co-ordinates and return the geographical center
    coords_array = []
    @event.invitations.each do |i|
      coords_array << { latitude: i.latitude, longitude: i.longitude }
    end
    @geo_center = average_geo_location(coords_array)
    # raise
  end

  def average_geo_location(coords)
    return coords[0] if coords.length == 1

    x = 0.0
    y = 0.0
    z = 0.0
    coords.each do |coord|
      latitude = coord[:latitude] * Math::PI / 180
      longitude = coord[:longitude] * Math::PI / 180
      x += Math.cos(latitude) * Math.cos(longitude)
      y += Math.cos(latitude) * Math.sin(longitude)
      z += Math.sin(latitude)
    end
    total = coords.length
    x /= total
    y /= total
    z /= total
    central_longitude = Math.atan2(y, x)
    central_square_root = Math.sqrt(x * x + y * y)
    central_latitude = Math.atan2(z, central_square_root)
    { latitude: central_latitude * 180 / Math::PI, longitude: central_longitude * 180 / Math::PI }
  end

  def yelp_api_call(geo_center, most_frequent_cuisine)
    # calls api with results of yelp_cuisine_logic and yelp_location
    # example url = https://api.yelp.com/v3/businesses/search?term=thai,restaurants&latitude=37.786882&longitude=-122.399972
    url = URI("https://api.yelp.com/v3/businesses/search?term=#{most_frequent_cuisine},restaurants&latitude=#{geo_center[:latitude]}&longitude=#{geo_center[:longitude]}")
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    key = ENV["YELP_KEY"]
    request["Authorization"] = ENV["YELP_KEY"]
    response = https.request(request)
    yelp_json = JSON.parse(response.read_body)
    create_restaurant(yelp_json["businesses"].first)
  end

  def create_restaurant(hash)
    new_restaurant = Restaurant.new(
      yelp_id: hash["id"],
      name: hash["name"],
      description: hash["categories"][0]["title"],
      location: hash["location"]["display_address"].first
    )
    new_restaurant.save!
  end

  private

  def result_params
    params.permit(:event_id)
  end
end

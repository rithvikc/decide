class ResultsController < ApplicationController
  include Enumerable

  def create
    @result = Result.new(result_params)
    @event = Event.find(params[:event_id])
    @restaurant = Restaurant.find(1)
    yelp_cuisine_logic
    yelp_location_logic
    @result.restaurant = @restaurant
    @result.event = @event
    @result.save!
    redirect_to event_result_path[@event, @result]
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

  def yelp_api_call
    # calls api with results of yelp_cuisine_logic and yelp_location
    #   require 'open-uri'
    #   require 'json'
    #   require 'net/http'
    #   # require 'openssl'
    #   api_url = "https://api.yelp.com/v3/businesses/search"

    #   http = Net::HTTP.new(url.host, url.port)
    #   http.use_ssl = true
    #   http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    #   request = Net::HTTP::Post.new(url)
    #   request["x-rapidapi-key"] = '37445f6bdcmshf761d925b5f4361p1582ffjsn49d8d7c2766a'

    #   response = http.request(request)
    #   puts response.read_body
    # end
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

  private

  def result_params
    params.permit(:event_id)
  end

  def restaurant_params

  end
end

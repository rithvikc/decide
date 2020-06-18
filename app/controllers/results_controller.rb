class ResultsController < ApplicationController
  require 'json'
  require 'open-uri'
  require "uri"
  require 'net/http'

  def show
    @event = Event.find(params[:event_id])
    @result = @event.result
    @event.decided = true
    @event.save!
    @markers = @event.invitations.map do |i|
      { lat: i.latitude,
        lng: i.longitude,
        image_url: helpers.asset_url('map-user-blue.png') }
    end
    # @markers << {
    #   lat: @result.restaurant.latitude,
    #   lng: @result.restaurant.longitude,
    #   image_url: helpers.asset_url('marker-star.png')

    #   # infoWindow: render_to_string(partial: "info_window", locals: { restaurant: @restaurant })
    # }
    @location_info = {
      lat: @result.restaurant.latitude,
      lng: @result.restaurant.longitude,
      image_url: helpers.asset_url('marker-star.png'),
      name: @result.restaurant.name,
      ratings: @result.restaurant.ratings,
      info_window_html: render_to_string(partial: "info_window", locals: { restaurant: @result.restaurant })
    }
    @google_url = "https://maps.google.com/?q=#{@result.restaurant.name} #{@result.restaurant.location}"
  end

  def create
    @result = Result.new(result_params)
    @event = Event.find(params[:event_id])
    if @event.invitations.any? { |h| h[:status] == "Confirmed" }
      geo_center = find_geo_center(@event)
    else
      flash[:notice] = "No one is invited to your event!"
      redirect_to event_path(@event) and return
    end
    # start_at = @event.start_at.to_i
    # unix_start_at_with_timezone = set_timezone(lat, long, start_at)
    top_cuisine = find_top_cuisine(@event)
    lat = geo_center[:latitude]
    long = geo_center[:longitude]
    unless yelp_results(lat, long, top_cuisine)
      flash[:notice] = "Sorry, we couldn't find any results near your location!"
      redirect_to event_path(@event) and return
    end
    @result.restaurant = @new_restaurant
    @result.event = @event
    if @result.save
      @event.decided = true
      redirect_to event_result_path(@event, @result)
    else
      flash[:notice] = "Sorry, we're too busy right now. Please try again!"
      redirect_to event_path(@event) and return
    end
  end

  def set_timezone(lat, long, start_at)
    url = URI("https://maps.googleapis.com/maps/api/timezone/json?location=#{lat},#{long}&timestamp=#{start_at}&key=#{ENV['GPLACES_KEY']}")
    api_key = "" # Placed in above URL
    response = api_call(url, api_key)
    hash = parse(response)
    (start_at + hash["dstOffset"] + hash["rawOffset"])
  end

  def restaurant_create
    @restaurant = Restaurant.new(restaurant_params)
  end

  def find_top_cuisine(event)
    # counts the user selection of cuisines and returns the most picked cuisine
    cuisine_array = []
    event.invitations.each do |i|
      cuisine_array << i.cuisine.name
    end
    cuisine_array.max_by { |i| cuisine_array.count(i) }
  end

  def find_geo_center(event)
    # accept an an array of hashes of user co-ordinates and return the geographical center
    coords_array = []
    event.invitations.each do |i|
      coords_array << { latitude: i.latitude, longitude: i.longitude } if i.status == 'Confirmed'
    end
    average_geo_location(coords_array)
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

  def yelp_results(lat, long, food)
    radius = 2000
    # fail_block = "22221231231212512"
    # url = URI("https://api.yelp.com/v3/businesses/search?term=#{food}&latitude=#{lat}&longitude=#{long}&radius=#{radius}&open_at=#{time}")
    url = URI("https://api.yelp.com/v3/businesses/search?term=#{food}&latitude=#{lat}&longitude=#{long}&radius=#{radius}")
    api_key = ENV["YELP_KEY"]
    response = api_call(url, api_key)
    if response.kind_of? Net::HTTPSuccess
      yelp_json = parse(response)["businesses"]
      if yelp_json.empty?
        zomato_api_call(lat, long, food)
      else
        ordered_results = sort_yelp_results(yelp_json, radius)
        create_restaurant_yelp(ordered_results.first)
      end
    else
      zomato_api_call(lat, long, food)
    end
  end

  def sort_yelp_results(json, radius)
    json.map do |j|
      decide_rating = j["rating"] * (radius - j["distance"])
      j["decide_rating"] = decide_rating
    end
    json.sort_by { |hash| -hash['decide_rating'] }
  end

  def zomato_api_call(lat, long, food)
    radius = 2000
    url = URI("https://developers.zomato.com/api/v2.1/search?lat=#{lat}&lon=#{long}&radius=#{radius}&cuisines=#{food}&sort=real_distance&order=desc")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["user-key"] = ENV["ZOMATO_KEY"]
    response = https.request(request)
    if response.kind_of? Net::HTTPSuccess
      zomato_json = JSON.parse(response.read_body)["restaurants"]
      sort_zomato_results(zomato_json, radius, lat, long)
      create_restaurant_zomato(zomato_json)
    else
      return false
    end
  end

  def sort_zomato_results(json, radius, lat, long)
    json.map do |j|
      r_coords = [j["restaurant"]["location"]["latitude"], j["restaurant"]["location"]["longitude"]]
      g_coords = [lat, long]
      distance = Geocoder::Calculations.distance_between(r_coords, g_coords) * 1000
      rating = j["restaurant"]["user_rating"]["aggregate_rating"].to_f
      decide_rating = rating * (radius - distance)
      j["decide_rating"] = decide_rating
    end
    json.sort_by { |hash| -hash['decide_rating'] }
  end

  def create_restaurant_yelp(hash)
    @new_restaurant = Restaurant.new(
      # yelp_id: hash["url"],
      name: hash["name"],
      description: hash["categories"][0]["title"],
      location: hash[
        "location"]["display_address"].join(", "),
      ratings: hash["rating"],
      # price: hash["price"].size,
      # image_url: hash["image_url"],
      latitude: hash["coordinates"]["latitude"],
      longitude: hash["coordinates"]["longitude"]
    )
    @new_restaurant.save!
  end

  def create_restaurant_zomato(hash)
    first_result = hash.first
    @new_restaurant = Restaurant.new(
      # yelp_id: first_result["restaurant"]["url"],
      name: first_result["restaurant"]["name"],
      description: first_result["restaurant"]["cuisines"],
      location: first_result["restaurant"]["location"]["address"],
      ratings: first_result["restaurant"]["user_rating"]["aggregate_rating"],
      # price: first_result["restaurant"]["price_range"],
      # image_url: first_result["restaurant"]["featured_image"],
      latitude: first_result["restaurant"]["location"]["latitude"],
      longitude: first_result["restaurant"]["location"]["longitude"]
    )
    @new_restaurant.save!
  end

  private

  def api_call(url, api_key)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["Authorization"] = api_key
    https.request(request)
  end

  def parse(response)
    JSON.parse(response.read_body)
  end

  def result_params
    params.permit(:event_id)
  end
end

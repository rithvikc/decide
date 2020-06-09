class ResultsController < ApplicationController
  def restaurant_create
    @restaurant = Restaurant.new(restaurant_params)

  end

  def create
    @result = Result.new(result_params)
    @event = Event.find(params[:event_id])
    @result.restaurant = @restaurant
    @result.event = @event
    @result.save!
  end

  def yelp_cuisine_logic
    # counts the user selection of cuisines and returns the most picked cuisine
  end

  def yelp_location(array_of_coords)
    # accept an array of user co-ordinates and return the geographical center
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

end

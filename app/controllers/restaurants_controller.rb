class RestaurantsController < ApplicationController

  def index
    @latitude, @longitude = user_location

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(Restaurant.all, @latitude, @longitude)
  end

  private

  def user_location
    # defaults
    latitude = 60.172389
    longitude = 24.947516

    if !params[:latitude].nil? and !params[:longitude].nil?
      latitude = params[:latitude].to_f
      longitude = params[:longitude].to_f
      cookies[:location] = { "latitude" => latitude, "longitude" => longitude }.to_json
    elsif !cookies[:location].nil?
      last_known_location = JSON.parse(cookies[:location])
      latitude = last_known_location["latitude"]
      longitude = last_known_location["longitude"]
    end

    return latitude, longitude
  end

end

class RestaurantsController < ApplicationController

  def index
    Location.coordinates = user_location

    cookies[:location] = { "latitude" => Location.latitude,
                           "longitude" => Location.longitude }.to_json

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(Restaurant.all,
                                               Location.coordinates)
  end

  private

  def user_location
    if params[:address]
      location = Geocoder.search("#{params[:address]}")
      return location.first.coordinates if location.count > 0
    end

    if !params[:latitude].nil? and !params[:longitude].nil?
      return params[:latitude].to_f, params[:longitude].to_f
    end

    if cookies[:location]
      return Location.parse_location_from_json cookies[:location]
    end

    return Location.default_location
  end

end

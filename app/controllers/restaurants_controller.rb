class RestaurantsController < ApplicationController

  def index
    # defaults
    latitude = params[:latitude].nil? ? 60.172389 : params[:latitude].to_f
    longitude = params[:longitude].nil? ? 24.947516 : params[:longitude].to_f

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(Restaurant.all, latitude, longitude)
  end
end

class RestaurantsController < ApplicationController

  def index
    # defaults
    Location.latitude = params[:latitude].nil? ? 60.172389 : params[:latitude].to_f
    Location.longitude = params[:longitude].nil? ? 24.947516 : params[:longitude].to_f

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(Restaurant.all,
                                                Location.latitude,
                                                Location.longitude)
  end
end

class RestaurantsController < ApplicationController

  def index
    # defaults
    @latitude = 60.172389
    @longitude = 24.947516
    
    # sort by distance
    @restaurants = Restaurant.all
    @restaurants = Restaurant.sort_by_distance(@restaurants, @latitude, @longitude)
  end
end

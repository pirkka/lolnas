class RestaurantsController < ApplicationController

  def index
    # defaults
    @latitude = 60.172389
    @longitude = 24.947516

    @latitude = params[:latitude].to_f if params[:latitude]
    @longitude = params[:longitude].to_f if params[:longitude]

    # sort by distance
    @restaurants = Restaurant.all
    @restaurants = Restaurant.sort_by_distance(@restaurants, @latitude, @longitude)
  end
end

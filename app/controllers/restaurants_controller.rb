class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.all
    # defaults
    @latitude = 60.172389
    @longitude = 24.947516
  end
end

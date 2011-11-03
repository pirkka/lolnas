class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.find(:all)
  end
end

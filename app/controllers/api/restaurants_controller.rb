class Api::RestaurantsController < Api::ApiController

  def index
    @restaurants = Restaurant.all

    respond_with(@restaurants, :api_template => :valid_lunches_only)
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    respond_with(@restaurant, :api_template => :default)
  end

  def create
    @restaurant = Restaurant.create!(params[:restaurant])

    respond_with(@restaurant, :api_template => :default, :location => api_restaurant_url(@restaurant))
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    @restaurant.update_attributes!(params[:restaurant])

    respond_with(@restaurant, :api_template => :default, :location => api_restaurant_url(@restaurant))
  end

end

class Api::RestaurantsController < Api::ApiController
  load_and_authorize_resource

  def index
    # defaults
    @latitude = 60.172389
    @longitude = 24.947516

    @latitude = params[:latitude].to_f if params[:latitude]
    @longitude = params[:longitude].to_f if params[:longitude]

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(@restaurants, @latitude, @longitude)

    respond_with(@restaurants, :api_template => :valid_lunches_only)
  end

  def show
    respond_with(@restaurant, :api_template => :default)
  end

  def create
    @restaurant.save!

    respond_with(@restaurant, :api_template => :default, :location => api_restaurant_url(@restaurant))
  end

  def update
    @restaurant.update_attributes!(params[:restaurant])

    respond_with(@restaurant, :api_template => :default, :location => api_restaurant_url(@restaurant))
  end

end

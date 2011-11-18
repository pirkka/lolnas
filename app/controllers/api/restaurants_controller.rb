class Api::RestaurantsController < ApiController
  load_and_authorize_resource

  def index
    # defaults
    latitude = params[:latitude].nil? ? 60.172389 : params[:latitude].to_f
    longitude = params[:longitude].nil? ? 24.947516 : params[:longitude].to_f

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(@restaurants, latitude, longitude)

    respond_with(@restaurants,
                 :api_template => :valid_lunches_only,
                 :callback => params[:callback])
  end

  def show
    respond_with(@restaurant,
                 :api_template => :default,
                 :callback => params[:callback])
  end

  def create
    @restaurant.save!

    respond_with(@restaurant,
                 :api_template => :default,
                 :location => api_restaurant_url(@restaurant),
                 :callback => params[:callback])
  end

  def update
    @restaurant.update_attributes!(params[:restaurant])

    respond_with(@restaurant,
                 :api_template => :default,
                 :location => api_restaurant_url(@restaurant),
                 :callback => params[:callback])
  end

end

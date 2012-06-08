class RestaurantsController < ApplicationController

  def index
    if params[:address]
      location = Geocoder.search("#{params[:address]}")
      if location.count > 0
        Location.latitude, Location.longitude = location.first.coordinates
      end
    end

    unless Location.latitude
      # defaults
      Location.latitude = params[:latitude].nil? ? 60.172389 : params[:latitude].to_f
      Location.longitude = params[:longitude].nil? ? 24.947516 : params[:longitude].to_f
    end

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(Restaurant.all,
                                                Location.latitude,
                                                Location.longitude)
  end
end

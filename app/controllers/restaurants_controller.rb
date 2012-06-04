class RestaurantsController < ApplicationController

  def index
    # defaults
    @latitude = (session[:latitude].nil? or session[:latitude].to_f == 0) ? 60.172389 : session[:latitude].to_f
    @lontigude = (session[:longitude].nil? or session[:longitude].to_f == 0) ? 24.947516 : session[:longitude].to_f

    @latitude = session[:latitude] = params[:latitude].to_f unless params[:latitude].nil? or params[:latitude].to_f == 0
    @longitude = session[:longitude] = params[:longitude].to_f unless params[:longitude].nil? or params[:longitude].to_f == 0

    # sort by distance
    @restaurants = Restaurant.sort_by_distance(Restaurant.all, @latitude, @longitude)
  end
end

class Api::LunchesController < Api::ApiController

  def index
    @lunches = Lunch.by_restaurant_id(params[:restaurant_id]).all

    respond_with(@lunches, :api_template => :default)
  end

  def show
    @lunch = Lunch.by_restaurant_id(params[:restaurant_id]).find(params[:id])

    respond_with(@lunch, :api_template => :default)
  end

  def create
    @lunch = Lunch.new(params[:lunch])
    @lunch.restaurant_id = params[:restaurant_id]
    @lunch.save!

    respond_with(@lunch, :api_template => :default, :location => api_restaurant_lunch_url(params[:restaurant_id], @lunch))
  end

  def update
    @lunch = Lunch.find(params[:id])
    @lunch.update_attributes!(params[:lunch])

    respond_with(@lunch, :api_template => :default, :location => api_restaurant_lunch_url(params[:restaurant_id], @lunch))
  end

end

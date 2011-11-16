class Api::LunchesController < Api::ApiController
  before_filter :load_by_restaurant, :only => [:show, :update, :destroy]
  before_filter :create_by_restaurant, :only => [:create]
  load_and_authorize_resource

  def index
    @lunches = Lunch.by_restaurant_id(params[:restaurant_id]).all

    respond_with(@lunches, :api_template => :default)
  end

  def show
    respond_with(@lunch, :api_template => :default)
  end

  def create
#    @lunch.restaurant_id = params[:restaurant_id]
    @lunch.save!

    respond_with(@lunch, :api_template => :default, :location => api_restaurant_lunch_url(params[:restaurant_id], @lunch))
  end

  def update
    @lunch.update_attributes!(params[:lunch])

    respond_with(@lunch, :api_template => :default, :location => api_restaurant_lunch_url(params[:restaurant_id], @lunch))
  end

  def destroy
    respond_with(@lunch.destroy, :api_template => :default)
  end

  private

  def load_by_restaurant
    @lunch = Lunch.by_restaurant_id(params[:restaurant_id]).find(params[:id])
  end

  def create_by_restaurant
    @lunch = Lunch.new(params[:lunch])
    @lunch.restaurant_id = params[:restaurant_id]
  end

end

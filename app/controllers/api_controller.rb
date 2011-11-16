class ApiController < ApplicationController

  class ParameterMissingError < ActionController::ActionControllerError;end;

  rescue_from ActiveRecord::RecordInvalid, :with => :show_invalid_records
  rescue_from ActiveRecord::UnknownAttributeError, :with => :show_error_message
  rescue_from ActsAsApi::TemplateNotFoundError, :with => :api_template_not_found
  rescue_from ParameterMissingError, :with => :show_error_message

  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_api_user!, :except => [:index, :show]
  after_filter :sign_out_api_user!, :except => [:index, :show]

  self.responder = ActsAsApi::Responder
  respond_to :json, :xml

  def index
    respond_to :html
  end

  protected

  def api_template_not_found(exception)
    render :text => "Invalid schema", :status => 400
  end

  def show_invalid_records(exception)
    render :text => exception.record.errors.inspect, :status => 400
  end

  def show_error_message(exception)
    render :text => exception.message, :status => 400
  end

  def current_ability
    @current_ability ||= Ability.new(current_api_user)
  end

  private

  def sign_out_api_user!
    sign_out(:api_user)
  end

end

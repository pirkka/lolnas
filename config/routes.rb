Lolnas::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :api_users, :class_name => 'Api::User', :controllers => {:confirmations => "confirmations"}
  devise_scope :api_users do
    put "confirm_account", :to => "confirmations#confirm_account"
  end

  namespace :api do
    get '/', :action => "index"
    resources :restaurants do
      resources :lunches
    end
  end

  match '/lista' => 'restaurants#index'

  root :to => 'restaurants#index'
end
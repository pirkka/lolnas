Lolnas::Application.routes.draw do
  devise_for :api_users, :controllers => {:confirmations => "confirmations"} do
    put "confirm_account", :to => "confirmations#confirm_account"
  end

  ActiveAdmin.routes(self)

  devise_for :users, ActiveAdmin::Devise.config

  namespace :api do
    resources :restaurants do
      resources :lunches
    end
  end

  match '/lista' => 'restaurants#index'

  root :to => 'welcome#index'
end
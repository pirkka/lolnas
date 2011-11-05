Lolnas::Application.routes.draw do
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
Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resource :api_key, only: %i(show)
    end
  end

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :api_keys, except: %i(edit update show)
  resources :bookmarks

  # Defines the root path route ("/")
  root to: "pages#home"
end

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route for Spotify OAuth callback
  get '/auth/spotify/callback', to: 'sessions#spotify'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route for Spotify OAuth callback
  get '/auth/spotify/callback', to: 'sessions#spotify'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  get '/posts', to: 'posts#index'

  # Defines the root path route ("/")
  resources :posts, only: [:index, :show]

  # root "posts#index"
end

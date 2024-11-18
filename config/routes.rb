Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Route for Spotify OAuth callback
  get '/auth/spotify/callback', to: 'sessions#spotify'

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check
  get "users/:id/recommendations", to: "users#recommendations", as: :recommendations

  resources :users, only: [:show] do
    member do
      post 'follow', to: 'follows#create'
      delete 'unfollow', to: 'follows#destroy'
      get :followers
      get :following
    end
  end

  resources :posts do
    resources :comments, only: [:create]
  end

  resources :tracks do
    collection do
      get :search
    end
  end
end

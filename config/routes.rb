Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users, only: [:create]

  post '/login', to: 'sessions#create'
  get '/register', to: 'users#new'
  post '/dashboard', to: 'users#create'
  get '/dashboard', to: 'dashboard#index'
  get '/status/:token', to: 'status#index', as: :status

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show] do
        post "/shots", to: "games/shots#create"
      end
    end
  end
end

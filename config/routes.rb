Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'

  resources :users, only: [:create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  post '/dashboard', to: 'users#create'
  get '/dashboard', to: 'dashboard#index'
  get '/status/:token', to: 'status#index', as: :status

  namespace :api do
    namespace :v1 do
      resources :games, only: [:show, :create] do
        post '/shots', to: 'games/shots#create'
        post '/ships', to: "games/ships#create"
        # get '/ships', to: "games/ships#index"
      end
    end
  end
end

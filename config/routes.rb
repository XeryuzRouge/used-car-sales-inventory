Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :cars, only: [:index, :create, :destroy]

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
end

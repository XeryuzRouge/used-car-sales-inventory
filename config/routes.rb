Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :cars, only: [:index, :create]
end

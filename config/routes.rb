Rails.application.routes.draw do
  root 'sessions#new'

  get 'ingredients', to: 'ingredients#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
end

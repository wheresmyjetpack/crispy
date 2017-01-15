Rails.application.routes.draw do
  root 'pantry_items#index'

  get 'pantry_items', to: 'pantry_items#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :users
end

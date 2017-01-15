Rails.application.routes.draw do
  root 'ingredients#index'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'shopping_list', to: 'shopping_items#show'
  get 'shopping_list/new', to: 'shopping_items#new'
  post 'shopping_list', to: 'shopping_items#create'

  get 'ingredients', to: 'ingredients#index'
  resources :users
end

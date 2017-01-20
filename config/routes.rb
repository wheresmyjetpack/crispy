Rails.application.routes.draw do
  root 'sessions#new'

  get 'login', to: 'sessions#new'

  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'shopping_list', to: 'shopping_items#show'
  get 'shopping_list/new', to: 'shopping_items#new'
  post 'shopping_list', to: 'shopping_items#create'
  delete 'shopping_list', to: 'shopping_items#destroy'
  post 'shopping_list/persist', to: 'shopping_items#persist'

  resources :ingredients
  resources :users
end

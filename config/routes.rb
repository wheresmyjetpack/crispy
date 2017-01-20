Rails.application.routes.draw do
  root 'users#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'shopping_list', to: 'shopping_items#show'
  get 'shopping_list/new', to: 'shopping_items#new'
  post 'shopping_list', to: 'shopping_items#create'
  post 'shopping_list/persist', to: 'shopping_items#persist'
  delete 'shopping_list', to: 'shopping_items#destroy'

  resources :ingredients
end

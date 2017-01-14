Rails.application.routes.draw do
  root 'pantry_items#index'
  resources :pantry_items, only: [:index]
end

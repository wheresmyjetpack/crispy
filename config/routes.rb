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

  get 'sign_up', to: 'users#new'
  post 'sign_up', to: 'users#create'

  namespace 'api' do
    namespace 'v1' do
      get 'measurements', to: 'measurements#index'
    end
  end

  resources :ingredients
end

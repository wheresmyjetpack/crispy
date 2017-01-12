Rails.application.routes.draw do
  get 'pantry_items/', to: 'pantry_items#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

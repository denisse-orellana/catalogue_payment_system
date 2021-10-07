Rails.application.routes.draw do
  resources :orders
  resources :products
  resources :profiles

  root "orders#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  resources :products
  devise_for :users
  root to: 'dashboard#index'
end

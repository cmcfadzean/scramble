Rails.application.routes.draw do
  resources :rounds
  devise_for :users
  root 'rounds#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

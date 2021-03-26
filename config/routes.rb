Rails.application.routes.draw do
#  get 'checks/new'
#  get 'checks/perform'
#  get 'postcodes/new'
#  get 'api/allowed_postcodes'
#  get 'api/check'
  
  resources :postcodes, only: [:new, :create, :index, :destroy]
  resources :checks, only: [:new, :create]
  root 'application#index'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

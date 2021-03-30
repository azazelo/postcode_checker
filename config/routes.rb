Rails.application.routes.draw do
  get 'checking', to: 'checks#checking'
  post 'perform', to: 'checks#perform'
#  get 'checks/perform'
#  get 'postcodes/new'
#  get 'api/allowed_postcodes'
#  get 'api/check'
  
  resources :postcodes, only: [:new, :create, :index, :destroy]
#  resources :checks, only: [:check]
  
  root 'checks#checking'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

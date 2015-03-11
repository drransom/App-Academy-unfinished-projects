Rails.application.routes.draw do
  # get 'user/username:string'
  #
  # get 'user/password_digest:string'
  #
  # get 'user/session_token:string'

  root to: 'cats#index'
  resources :cats, only: [:index, :create, :new, :show, :update, :edit, :destroy]
  resources :cat_rental_requests
  resources :users
end

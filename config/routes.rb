Rails.application.routes.draw do
  # get 'user/username:string'
  #
  # get 'user/password_digest:string'
  #
  # get 'user/session_token:string'

  root to: 'cats#index'
  resources :cats
  resources :cat_rental_requests
  resources :users
  resource :session
end

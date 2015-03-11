Rails.application.routes.draw do
  # get 'user/username:string'
  #
  # get 'user/password_digest:string'
  #
  # get 'user/session_token:string'

  root to: 'cats#index'
  resources :cats
  resources :cat_rental_requests do
    member do
      get "approve"
      get "deny"
    end
  end
  resources :users
  resource :session
end

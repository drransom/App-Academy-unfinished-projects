Rails.application.routes.draw do
  root to: 'cats#index'
  resources :cats, only: [:index, :create, :new, :show, :update, :edit, :destroy]
  resources :cat_rental_requests
end

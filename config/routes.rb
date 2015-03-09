Rails.application.routes.draw do
  resources :users, only: [:index, :create, :update, :show, :destroy]
  resources :contacts, only: [:index, :create, :update, :show, :destroy]
end

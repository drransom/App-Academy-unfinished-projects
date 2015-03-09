Rails.application.routes.draw do
  resources :users, only: [:index, :create, :update, :show, :destroy] do
    resources :contacts, only: [:index]
  end
  resources :contacts, only: [:create, :update, :show, :destroy]
  resources :contact_shares, only: [:create, :destroy]
end

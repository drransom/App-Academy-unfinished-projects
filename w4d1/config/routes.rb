Rails.application.routes.draw do
  resources :users, only: [:index, :create, :update, :show, :destroy] do
    resources :contacts, only: [:index]
    resources :comments, only: [:index, :create, :destroy]
  end

  resources :contacts, only: [:create, :update, :show, :destroy] do
    resources :comments, only: [:index, :create, :destroy]
  end

  resources :contact_shares, only: [:create, :destroy]
end

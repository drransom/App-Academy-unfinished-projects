Rails.application.routes.draw do
  root to: redirect("/sessions/new")
  resources :users, only: [:new, :create, :show]
  resource :sessions, only: [:new, :create, :destroy]
end

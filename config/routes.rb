Rails.application.routes.draw do
  resources :users, except: [:edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy]
end

Rails.application.routes.draw do
  resources :users, except: [:edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new]
  end

  resources :posts, only: [:create, :edit, :update, :show] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create, :show]
end

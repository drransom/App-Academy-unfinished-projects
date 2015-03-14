Rails.application.routes.draw do
  resources :users, except: [:edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :subs, except: [:destroy] do
    resources :posts, only: [:new]
  end

  resources :posts, only: [:create, :edit, :update, :show] do
    resources :comments, only: [:new]
    post '/upvote' => 'posts#upvote'
    post '/downvote' => 'posts#downvote'
  end
  resources :comments, only: [:create, :show] do
    post '/upvote' => 'comments#upvote'
    post '/downvote' => 'comments#downvote'
  end
end

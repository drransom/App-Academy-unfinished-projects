Rails.application.routes.draw do
  resources :users do
    resources :goals, only: [:new]
  end
  resources :goals, except: [:new]
  resource :session
  post 'goals/:id/complete', to: "goals#complete", as: 'complete_goal'
end

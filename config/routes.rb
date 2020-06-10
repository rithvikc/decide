Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resource :dashboard, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :cuisine_events, only: [:new, :create]
  get 'kitchensink', to: 'pages#kitchensink'

  resources :restaurants, only: :create
  resources :events, only: [:new, :create, :show] do
    resources :invitations, only: [:new, :create, :show]
    resources :cuisine_events, only: [:create]
    resources :results, only: [:new, :create, :show]
  end
end

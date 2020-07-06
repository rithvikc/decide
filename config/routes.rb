Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'home/index'
  # devise_for :users, controllers: { invitations: 'users/invitations' }

  authenticated :user do
    root 'dashboards#show', as: 'authenticated_root'
  end
  devise_scope :user do
    root 'pages#home'
  end

  resource :dashboard, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :cuisine_events, only: [:new, :create]
  get 'kitchensink', to: 'pages#kitchensink'
  get 'test', to: 'pages#test'

  resources :events, only: [] do
    namespace :invitations do
      resources :attendences, only: [:create, :destroy]
    end
  end


  resources :restaurants, only: :create
  resources :events, only: [:new, :create, :show, :index] do
    resources :mass_invitations, only: [:create]
    resources :invitations, only: [:new, :create, :show]
    resources :cuisine_events, only: [:create]
    resources :results, only: [:new, :create, :show]
    post 'invite', to: 'events#invite'
  end
end

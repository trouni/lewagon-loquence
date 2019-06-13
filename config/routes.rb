Rails.application.routes.draw do
  get 'users/create'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#home'
  resources :reports do
    resources :widgets, only: :create
    resources :report_accesses, only: [:create, :update, :destroy]
  end
  resources :widgets, only: %i[destroy edit update]

  get 'settings', to: 'settings#account', as: 'settings'
  get 'settings/account', to: 'settings#account'
  get 'settings/users', to: 'settings#users'
  post 'settings/invite', to: 'settings#create'

  resources :onboarding
  get 'info', to: 'pages#info'

  post 'filters', to: 'reports/filters#create', as: 'filters'
end

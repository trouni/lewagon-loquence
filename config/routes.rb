Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#home'
  resources :reports do
    resources :widgets, only: [:create, :update]
    resources :report_accesses, only: [:create, :update, :destroy]
  end
  resources :widgets, only: :destroy
  resources :users
  get 'settings', to: 'settings#account', as: 'settings'
  get 'settings/account', to: 'settings#account'
  get 'settings/users', to: 'settings#users'
  resources :onboarding
  get 'info', to: 'pages#info'
end

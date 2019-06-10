Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :reports do
    resources :widgets, only: [:create, :update]
  end
  resources :widgets, only: :destroy
  resources :users
  get 'settings', to: 'settings#account', as: 'settings'
  get 'settings/account', to: 'settings#account'
  get 'settings/users', to: 'settings#users'
end

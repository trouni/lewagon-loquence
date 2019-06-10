Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: 'pages#home'
  resources :reports, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :widgets, only: [:create, :update]
  end
  resources :widgets, only: :destroy
  resources :onboarding
end

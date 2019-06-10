Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :reports, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :widgets, only: [:create, :update]
  end
  resources :widgets, only: :destroy
  recourses :onboarding
end

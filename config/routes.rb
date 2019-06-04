Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :reports, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    # resources :widgets, only: [:create, :update] do
      # resources :widget_kpis, only: [:create, :update]
    # end
  end
  # resources :kpis, only: [:new, :create, :edit, :update, :destroy]
  # resources :widgets, only: :destroy
  # resources :widget_kpis, only: :destroy
end

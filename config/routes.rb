Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'dashboard#index'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    resources :prices, only: [:edit, :update]
    post 'reset_defaults', to: 'prices#reset_defaults'
    
    resources :settings, only: [:edit, :update]
    patch 'update_setting/:id', to: 'settings#update', as: 'update_setting'
    patch 'update_price/:id', to: 'prices#update', as: 'update_price'
  end
  
  root 'pages#home'
  resources :contacts, only: [:create]
  get 'carpet_price_calculator', to: 'carpets#price_calculator'
  post 'carpet_price_calculator', to: 'carpets#price_calculator'
end


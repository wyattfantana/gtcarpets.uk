Rails.application.routes.draw do
  get 'gallery', to: 'gallery#index'
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

    resources :galleries
    patch 'update_gallery/:id', to: 'galleries#update', as: 'update_gallery'
    patch 'bulk_galleries', to: 'galleries#bulk_action'

    resources :links
    patch 'update_link/:id', to: 'links#update', as: 'update_link'
    patch 'bulk_links', to: 'links#bulk_action'
  end
  
  root 'pages#home'
  get 'links', to: 'pages#links'
  resources :contacts, only: [:create]
  get 'carpet_price_calculator', to: 'carpets#price_calculator'
  post 'carpet_price_calculator', to: 'carpets#price_calculator'
end


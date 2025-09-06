Rails.application.routes.draw do
  namespace :admin do
    get '/', to: 'prices#index'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
    
    resources :prices, only: [:index, :edit, :update]
  end
  
  root 'pages#home'
  resources :contacts, only: [:create]
  get 'carpet_price_calculator', to: 'carpets#price_calculator'
  post 'carpet_price_calculator', to: 'carpets#price_calculator'
end


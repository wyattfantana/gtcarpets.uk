Rails.application.routes.draw do
  root 'pages#home'
  resources :contacts, only: [:create]
    get 'carpet_price_calculator', to: 'carpets#price_calculator'
  post 'carpet_price_calculator', to: 'carpets#price_calculator'
end


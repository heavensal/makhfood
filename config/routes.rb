Rails.application.routes.draw do

  resources :products
  resources :categories
  resources :brands

  resources :quote_items, only: [:create, :update, :destroy]

  get 'quote', to: 'quotes#show', as: 'quote'
  patch 'quote', to: "quotes#update"
  get 'quotes/:id/send', to: 'quotes#send_my_quote', as: 'send_my_quote'

  root 'pages#home'
  get '/legal', to: 'pages#legal', as: 'legal'
  get '/privacy_policy', to: 'pages#policy', as:'policy'
  get '/cgu', to: 'pages#cgu', as: 'cgu'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

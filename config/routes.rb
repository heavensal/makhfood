Rails.application.routes.draw do
  root 'products#index'

  resources :products
  resources :categories
  resources :brands

  resources :quote_items, only: [:create, :update, :destroy]

  get 'quote', to: 'quotes#show', as: 'quote'
  get 'quotes/:id/send', to: 'quotes#send_my_quote', as: 'send_my_quote'

  get 'pages/infos', to: 'pages#infos', as: 'infos'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

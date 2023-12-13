Rails.application.routes.draw do
  root 'products#index'
  resources :products
  get 'viandes', to: 'products#viandes', as: 'viandes'
  get 'boissons', to: 'products#boissons', as: 'boissons'
  get "epicerie", to: 'products#epicerie', as: 'epicerie'
  get 'pages/infos', to: 'pages#infos', as: 'infos'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

Rails.application.routes.draw do
  devise_for :admins

  resources :products
  resources :categories
  resources :brands

  resources :quote_items, only: [:create, :edit, :update, :destroy]

  get 'quote', to: 'quotes#show', as: 'quote'
  get 'quote/edit', to: 'quotes#edit', as: 'edit_quote'
  patch 'quote', to: "quotes#update"
  get 'quotes/:id/send', to: 'quotes#send_my_quote', as: 'send_my_quote'

  root 'pages#home'

  get 'redirect', to: 'pages#redirect', as: 'redirect'

  get 'legal', to: 'pages#legal', as: 'legal'
  get 'privacy_policy', to: 'pages#policy', as:'policy'
  get 'cgu', to: 'pages#cgu', as: 'cgu'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end

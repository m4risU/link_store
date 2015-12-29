require 'sidekiq/web'

Rails.application.routes.draw do
  resources :sites, only: [:edit, :update, :index]
  root to: 'sites#index'
  mount Sidekiq::Web => '/sidekiq'
end

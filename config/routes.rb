require 'sidekiq/web'

Rails.application.routes.draw do
  resources :sites
  root to: 'sites#index'
  resources :sites
  mount Sidekiq::Web => '/sidekiq'
end

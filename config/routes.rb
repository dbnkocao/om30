require "sidekiq/web"

Rails.application.routes.draw do
  resources :municipes, except: [:destroy]

  mount Sidekiq::Web => "/sidekiq"

  root to: "municipes#index"
end

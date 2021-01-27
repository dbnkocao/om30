require "sidekiq/web"

Rails.application.routes.draw do
  resources :municipes, except: [:destroy, :new, :edit]

  mount Sidekiq::Web => "/sidekiq"

  root to: "municipes#index"
end

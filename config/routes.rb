require "sidekiq/web"

Rails.application.routes.draw do
  resources :municipes, except: [:destroy]
  put "/municipes/:id/change_status", to: "municipes#change_status"
  get "/municipes_list", to: "municipes#get_list"

  mount Sidekiq::Web => "/sidekiq"

  root to: "municipes#index"
end

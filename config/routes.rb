require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  resources :municipes, except: [:destroy]
  put "/municipes/:id/change_status", to: "municipes#change_status"
  get "/municipes_list", to: "municipes#get_list"

  root to: "municipes#index"
end

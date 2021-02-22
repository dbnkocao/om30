require "sidekiq/web"

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"

  resources :municipes, except: [:destroy]
  put "/municipes/:id/change_status", to: "municipes#change_status"
  get "/municipes_list", to: "municipes#get_list"

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :municipes, only: [:index, :show, :create, :update]
    end
  end

  root to: "municipes#index"
end

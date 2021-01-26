Rails.application.routes.draw do
  resources :municipes, except: [:destroy]

  root to: "municipes#index"
end

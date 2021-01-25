Rails.application.routes.draw do
  resources :municipes, except: [:destroy]

  root to: "municipes#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

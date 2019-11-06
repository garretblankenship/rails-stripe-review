Rails.application.routes.draw do
  root to: "fish#index"
  resources :fish
  devise_for :users
  get "/orders/success", to: "orders#success", as: "success_order"
  post "/orders/webhook", to: "orders#webhook", as: "order"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

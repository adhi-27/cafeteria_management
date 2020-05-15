Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"

  resources :users
  resources :menus
  resources :menu_items
  resources :order_items
  resources :orders

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#delete", as: :destroy_sessions

  get "/cafeteria" => "cafeteria#index"
  get "/cafeteria/menus" => "cafeteria#menus", as: :create_menus
  get "/cafeteria/users" => "cafeteria#users"
  get "/cafeteria/cart" => "cafeteria#cart"
  get "/cafeteria/orders" => "cafeteria#orders"
  put "/cafeteria/menus/activate" => "cafeteria#activate", as: :activate_menu

  get "/orders/confirm" => "orders#confirm"
end

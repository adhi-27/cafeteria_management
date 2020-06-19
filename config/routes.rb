Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"

  put "/orders/confirm" => "orders#confirm"

  resources :users
  resources :menus
  resources :menu_items
  resources :order_items
  resources :orders
  resources :specific_menu_items

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#delete", as: :destroy_sessions

  get "/cafeteria" => "cafeteria#index"
  get "/cafeteria/cart" => "cafeteria#cart"
  get "/cafeteria/orders" => "cafeteria#orders"
  get "/cafeteria/menus" => "cafeteria#menus", as: :create_menus
  get "/cafeteria/menu_items" => "cafeteria#menu_items"
  get "/cafeteria/additem" => "cafeteria#add_item"
  put "/cafeteria/menus/activate" => "cafeteria#activate", as: :activate_menu
  get "/cafeteria/users" => "cafeteria#users"
  get "cafeteria/about" => "cafeteria#about"
  get "cafeteria/sales_report" => "cafeteria#sales_report", as: :report
  post "cafeteria/change_report" => "cafeteria#change_report"
  get "cafeteria/order_range" => "cafeteria#order_range", as: :order_range
  post "cafeteria/change_order_range" => "cafeteria#change_order_range"
end

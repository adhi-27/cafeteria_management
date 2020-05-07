Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/" => "home#index"

  resources :users

  get "/signin" => "sessions#new", as: :new_sessions
  post "/signin" => "sessions#create", as: :sessions
  delete "/signout" => "sessions#delete", as: :destroy_sessions

  get "/cafeteria" => "cafeteria#index"
end

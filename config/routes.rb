Rails.application.routes.draw do
  resources :users
  resources :environments
  resources :shortcuts
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get    "/logged_in",  to: "sessions#logged_in"
  get "/", to: "sessions#test"
end

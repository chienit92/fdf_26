Rails.application.routes.draw do
  root "pages#show", page: "home"
  get "/pages/*page", to: "pages#show"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  resources :users, only: [:create, :show]
  resources :order_details, except: [:show, :new]
  resources :products, only: [:show, :index] do
     resources :comments, only: [:create, :destroy]
   end
  resources :orders, only: [:show, :update]
  namespace :admins do
    get "/admin_pages/*page", to: "admin_pages#show"
    resources :categories, except: [:new, :show]
    resources :products
    resources :orders, except: [:new, :delete]
    resources :users, except: [:show, :new, :edit]
  end
end

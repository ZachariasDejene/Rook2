Rails.application.routes.draw do
  
  resources :users
  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices
  resources :sessions

  resources :orders
  #resources :order_items
  resources :schools


  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy
  get 'order_history' => 'orders#order_history', as: :order_history

  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  get 'cart' => 'carts#index', :as => :show_cart
  get 'cart/add/:id' => 'carts#add_to_cart', :as => :add_to_cart
  get 'cart/remove/:id' => 'carts#remove_from_cart', :as => :remove_from_cart
  get 'cart/dump_cart' => 'carts#dump_cart', as: :dump_cart
  get 'cart/checkout' => 'carts#checkout', as: :checkout

  get 'order_items/ship/:id' => 'order_items#is_shipped', as: :ship
  get 'order_items' => 'order_items#is_shipped', as: :index
  
  get 'user/index' => 'users#index', as: :all_users

  # Set the root url
  root :to => 'home#home'  

end

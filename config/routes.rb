# -*- encoding : utf-8 -*-
Footbawwl::Application.routes.draw do
  
  #Create root path to index
  root :to => "user#home"
  
  resources :sessions

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "user#create", :as => "sign_up"
  
  post "fixtures/generate"
  
  # All the routes for the user display (League Table)
  get "/" => "user#home"
  
  get "/user/:user_id" => "user#show"
  
  post "user/create" => "user#create"
  post "user/update" => "user#update"
  delete "user/delete" => "user#delete"
  
  get "/user/:user_id/game_week/:game_week" => "user#game_week_team"
  post "/user/:user_id/game_week/:game_week/swap" => "user#swap_players"
  
  # Route for generating fixtures
  post "fixtures/generate"
  
  # Route for inputting stats
  post "nfl_player/stats/:game_week" => "nfl_player#update_stats"
  
  # All the routes for nfl player (haven't been checked as part of audit)
  get "nfl_player/unpicked"
  get "nfl_player/show/:id" => "nfl_player#show", as: :showplayer
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable
  resources :user

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

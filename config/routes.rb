# -*- encoding : utf-8 -*-
Footbawwl::Application.routes.draw do
  
  #Create root path to index
  root :to => "user#home"
    
  ##User account handling
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "user#create", :as => "sign_up"
  
  post "user/create" => "user#create"
  post "user/update" => "user#update"
  delete "user/delete" => "user#delete"
  
  ##Home
  get "/" => "user#home"

  ##User Team View  
  get "user/:user_id" => "user#show"
  post "user/declare_roster" => "user#declare_roster"
  get "user/:user_id/game_week/:game_week" => "user#show"
  
  get "user/:user_id/myteam" => "user#show_my_team_info"
  
  ##Transfer View
  get "transfer/status" => "transfer_request#status", :as => "transfer_request"
  get "transfer_request" => "transfer_request#status"
  
  #Route for adding players to team
  post "team_player/add_player" => "team_player#add_player"

  # Routes for generating stuff
  post "fixtures/generate"
  get "fixtures/week" => "fixtures#fixtures_for_week"
  get "fixtures/week/:game_week" => "fixtures#fixtures_for_week"

  post "progress_game_week" => "team_player#progress_game_week"
  
  # Route for inputting players
  post "nfl_player" => "nfl_player#create"

  # Route for inputting stats
  post "nfl_player/stats/:game_week" => "nfl_player#update_stats"
  
  # Routes for handling transfer requests
  post "transfer_request" => "transfer_request#create"
  post "transfer_request/:id" => "transfer_request#resolve"
  
  # Route for getting gameweek information
  get "gameweek/current" => "gameweek#get_current_gameweek"

  # All the routes for nfl player (haven't been checked as part of audit)
  get "nfl_player/unpicked"
  get "nfl_player/show/:id" => "nfl_player#show", as: :showplayer

  # Routes added as part of demoing the stats update stuff
  get "nfl_team" => "nfl_team#all"
  get "nfl_team/:id" => "nfl_team#show"     
  get "nfl_player/:id" => "nfl_player#show" 
  get "nfl_player/:id/game_week/:game_week" => "nfl_player#on_game_week"
  
  resources :user
  resources :sessions

end

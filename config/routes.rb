Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :profiles, only: %i[new create]
  resources :dashboards, only: %i[index]
  resources :game_sessions, only: %i[show index new create edit destroy]

  resources :chatrooms, only: %i[new create show index] do
    resources :messages, only: :create
  end

  resources :games, only: %i[index show]
  resources :games_lists
  get "my_games_list", to: "games_lists#my_games_list", as: :my_games_list
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

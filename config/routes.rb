Rails.application.routes.draw do
  # get 'games_session_lists/index'
  # get 'games_session_lists/available'
  devise_for :users
  root to: 'pages#home'

  resources :profiles, only: %i[new create]
  resources :dashboards, only: %i[index]
  resources :game_sessions, only: %i[show index new create edit destroy]
  resources :games_session_lists, only: %i[index new create]
  patch "games_session_lists/:id/available", to: "games_session_lists#available", as: :available

  resources :chatrooms, only: %i[new create show index] do
    resources :messages, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  get 'dashboards/index'
  devise_for :users

  resources :profiles, only: %i[new create]
  resources :dashboards, only: %i[index]

  resources :game_sessions, only: %i[new create edit destroy]
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

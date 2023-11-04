Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :teams
  devise_for :users
  get '/join/team', to: 'teams#join'
  post '/join/team', to: 'teams#join'
  #leave team route with id
  get '/leave/team/:id', to: 'teams#leave', as: 'leave_team'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index", as: :root
end

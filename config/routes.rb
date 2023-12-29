Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :teams
  devise_for :users
  get '/join/team', to: 'teams#join'
  post '/join/team', to: 'teams#join'
  post '/anketa', to: 'forms#submit_form'
  post '/discord', to: 'forms#submit_form_discord'
  # config/routes.rb
  post '/discord/send', to: 'discord_notifications#send_notification'
  get '/discord/send', to: 'discord_notifications#new_notification' # Optional: For rendering the form

  #leave team route with id
  delete '/leave/team/:id', to: 'teams#leave', as: 'leave_team'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index", as: :root
end

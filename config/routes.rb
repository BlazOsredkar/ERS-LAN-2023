Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  resources :teams
  devise_for :users
  get '/join/team', to: 'teams#join'
  post '/join/team', to: 'teams#join'
  post '/anketa', to: 'forms#submit_form'
  post '/discord', to: 'forms#submit_form_discord'
  post '/discord/send', to: 'discord_notifications#send_notification'
  get '/discord/send', to: 'discord_notifications#new_notification'
  delete '/leave/team/:id', to: 'teams#leave', as: 'leave_team'
  root "home#index", as: :root
  get "/verified_teams", to: "teams#verified_teams", as: :verified_teams
  get "/stream", to: "home#stream", as: :stream

end

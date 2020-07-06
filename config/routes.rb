Rails.application.routes.draw do
  devise_for :users, only: []
  devise_scope :user do
    post '/signup', to: 'registrations#create', defaults: {format: :json}
    post '/login', to: 'sessions#create', defaults: {format: :json}
    delete '/logout', to: 'sessions#destroy', defaults: {format: :json}
  end

  get '/users/me', to: 'users#me'

  post '/notifications', to: 'notifications#create'

  mount ActionCable.server => '/cable'
end

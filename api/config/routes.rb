Rails.application.routes.draw do
  post 'signup', to: 'users#create'
  post 'signin', to: 'sessions#create'
  get 'user', to: 'users#show'
end

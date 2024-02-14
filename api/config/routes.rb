Rails.application.routes.draw do
  # ユーザー関連
  post 'signup', to: 'users#create'
  post 'signin', to: 'sessions#create'
  get 'user', to: 'users#show'
  # アイテム関連
  post 'item/add', to: 'items#add'
end

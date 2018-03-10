Rails.application.routes.draw do
  root to: 'users#edit'

  resources :users, only: [:edit, :update]
end

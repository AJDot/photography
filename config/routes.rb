Rails.application.routes.draw do
  root to: 'ui#index'

  get 'ui(/:action)', controller: 'ui'
  resources :users, only: [:edit, :update]
end

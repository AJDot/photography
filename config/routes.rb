Rails.application.routes.draw do
  root to: 'pages#index'

  get 'ui', to: 'ui#index'
  Dir.glob('app/views/ui/*.html.haml').sort.each do |file|
    wireframe = File.basename(file, '.html.haml')
    unless wireframe == 'index' || wireframe.match(/^_/)
      get "ui/#{wireframe}", to: "ui##{wireframe}"
    end
  end
  get 'home', to: 'pages#home', as: 'home'
  resources :users, only: [:edit, :update]
  resources :kinds, only: [:index, :new, :create, :edit, :update]
  resources :sessions, only: [:index, :new, :create, :show, :edit, :update] do
    resources :images, only: [:create], controller: 'session_images'
  end
end

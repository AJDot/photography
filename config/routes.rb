Rails.application.routes.draw do
  root to: 'pages#root'

  get 'ui', to: 'ui#index'
  Dir.glob('app/views/ui/*.html.haml').sort.each do |file|
    wireframe = File.basename(file, '.html.haml')
    unless wireframe == 'index' || wireframe.match(/^_/)
      get "ui/#{wireframe}", to: "ui##{wireframe}"
    end
  end
  get 'home', to: 'pages#home', as: 'home'
  get 'sitemap', to: 'pages#index', as: 'sitemap'
  resources :users, only: [:edit, :update]
  resources :kinds, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :sessions do
    resources :images, only: [:create, :destroy], controller: 'session_images'
  end
  resources :prints, only: [:index]
  get 'about', to: 'pages#about', as: 'about'
  get 'book_me', to: 'book_me#new', as: 'book_mes'
  post 'book_me', to: 'book_me#create'
  post 'contact_me', to: 'contact_me#create', as: 'contact_mes'
end

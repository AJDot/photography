Rails.application.routes.draw do
  root to: 'ui#index'

  get 'ui', to: 'ui#index'
  Dir.glob('app/views/ui/*.html.haml').sort.each do |file|
    wireframe = File.basename(file, '.html.haml')
    unless wireframe == 'index' || wireframe.match(/^_/)
      get "ui/#{wireframe}", to: "ui##{wireframe}"
    end
  end
  resources :users, only: [:edit, :update]
  resources :sessions, only: [:new, :create]
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :donations, only: [:index, :create, :edit, :update]
  end
  
  resources :exhibits, only: [:index, :show]
  resources :animals, only: [:index, :show]

  namespace :zookeeper do
    resources :users do
      resources :animals, only: [:index, :create, :edit, :update, :show, :destroy] do
        resources :actions, only: [:index, :create]
      end
      resources :exhibits
    end
  end

  get '/', to: 'welcome#home'

  get '/signin', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  get '/auth/google_oauth2/callback', to: 'sessions#create_google'
  post '/sessions', to: 'sessions#create'
end

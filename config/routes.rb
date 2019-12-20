Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :donations, only: [:index, :create, :new, :edit, :show]
    resources :exhibits, only: [:show]

    get '/claim', to: 'exhibits#claim'
  end
  
  resources :exhibits
  resources :donations, only: [:update]

  namespace :zookeeper do
    resources :users do
      resources :animals, only: [:index, :create, :edit, :update, :show, :destroy] do
        resources :actions, only: [:create]
      end
      resources :exhibits
    end
  end

  get '/', to: 'welcome#home'

  get '/signin', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  post '/sessions', to: 'sessions#create'
end

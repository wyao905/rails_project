Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users do
    resources :donations
    
    get '/claim', to: 'exhibits#claim'
  end
  
  resources :animals, :exhibits

  get '/', to: 'welcome#home'

  get '/signin', to: 'sessions#new'
  get '/logout', to: 'sessions#destroy'
  post '/sessions', to: 'sessions#create'
end

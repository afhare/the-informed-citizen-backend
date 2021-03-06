Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :states
  resources :representatives
  resources :senators
  resources :users

  post '/login', to: 'users#login'
  get '/profile', to: 'users#show'
  post '/update-profile', to: 'users#update'
  post '/register', to: 'users#create'
  delete '/delete-user', to: 'users#destroy'
  post '/representatives-compare', to: 'representatives#compare'
  post '/senators-compare', to: 'senators#compare'
end

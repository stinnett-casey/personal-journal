Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users' => 'users#index'
  get '/users/:id' => 'users#show', as: 'user'
  resources :entries, except: [:show]
  get '/entry' => 'entries#show'
  root 'home#index'
end

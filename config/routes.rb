Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  Rails.application.routes.default_url_options[:host] = 'https://twitteraaa.herokuapp.com'

 
  get '/confirmationsuccessfull', to: 'home#successfull'
  root  'home#index'
  get '/index', to: 'tasks#index'
  resources :tasks

  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :destroy]
      resources :users, only: [:create, :index]
    end
    namespace :v2 do
      resources :tasks, only: [:index, :show, :create, :destroy]
      devise_scope :user do
        post '/authentication_tokens_signup', to: "registrations#create"
        post '/authentication_tokens_login', to: "sessions#create" 
        delete '/authentication_tokens_logout', to: "sessions#destroy"
        end
      end
  end

  

  #get '/confirmationsuccessfull', to: 'tasks#index'
  #resource: tasks
  
end

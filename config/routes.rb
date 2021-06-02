Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  Rails.application.routes.default_url_options[:host] = 'https://twitteraaa.herokuapp.com'
 
  get '/confirmationsuccessfull', to: 'home#successfull'
  root  'home#index'
  get '/index', to: 'tweets#index'
  resources :tweets
  resources :users, only:[ :show]
  resources :messages, only: [:index, :create]
  resources :timelines, only: [:index]
  resources :likes, only: [:create, :destroy]
  resources :followers, only: [:index, :show, :create, :destroy]
  resources :followings, only: [:index, :show, :create, :destroy]
  post '/friendships/:id', to: "friendships#seguir"
  resources :friendships, only: [:destroy]
  resources :hashtags, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :tweets, only: [:index, :show, :create, :destroy]
      resources :users, only: [:create, :index]
    end
    namespace :v2 do
      resources :tweets, only: [:index, :show, :create, :destroy]
      devise_scope :user do
        post '/users', to: "registrations#create"
        get '/users', to: "sessions#index" 
        delete '/users', to: "sessions#destroy"
      end
      get '/timeline', to: "timelines#index"
      post '/friendships/:id', to: "friendships#seguir"
      resources :likes, only: [:show, :destroy]
      post '/likes/:id', to: "likes#create"
      post '/messages/:id', to: "messages#create"
      resources :friendships, only: [:index, :show, :create, :destroy]
      resources :hashtags, only: [:index]
      resources :followers, only: [:index, :show, :create, :destroy]
      resources :followings, only: [:index, :show, :create, :destroy]
      #get '/friendship', to: "friendships#create"
    end  
  end

  
  
end

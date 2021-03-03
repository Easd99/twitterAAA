Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  devise_for :users
  get '/confirmationsuccessfull', to: 'home#successfull'
  root  'home#index'
  get '/index', to: 'tasks#index'
  resources :tasks
  
  #get '/confirmationsuccessfull', to: 'tasks#index'
  #resource: tasks
  
end

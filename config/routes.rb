Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #Rails.application.routes.default_url_options[:host] = 'https://twitteraaa.herokuapp.com'

 
  get '/confirmationsuccessfull', to: 'home#successfull'
  root  'home#index'
  get '/index', to: 'tasks#index'
  resources :tasks
  
  #get '/confirmationsuccessfull', to: 'tasks#index'
  #resource: tasks
  
end

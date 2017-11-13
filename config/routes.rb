Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :categories
  resources :statistics

  resources :posts do 
  member do
    put "use", to: "posts#use"
    put "unuse", to: "posts#unuse"
    end
  end
  
  devise_for :users
  resources :posts do
    resources :statistics
    end
  resources :categories do
  	resources :posts
  end
	
	root 'categories#index'
  post '/posts/new', to: 'posts#create'
  get '/post/:id/:name', to: 'posts#redirect'
  get '/statistics/:id', to: 'statistics#index'
  get '/transaction/new', to: 'transaction#generate'
end


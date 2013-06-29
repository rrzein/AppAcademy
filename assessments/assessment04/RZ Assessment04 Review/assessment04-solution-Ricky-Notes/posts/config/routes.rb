Posts::Application.routes.draw do
  resources :users
  resource :session
  resources :posts
  
  resources :tags, :only => [:create, :destroy]
end

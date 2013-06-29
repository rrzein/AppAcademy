Posts::Application.routes.draw do
  resources :users, :only => [:new, :create]
  resources :posts
  resources :tags, :only => [:create, :destroy]
  resource :session, :only => [:new, :destroy, :create]
  
end

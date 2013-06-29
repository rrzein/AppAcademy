Reddit::Application.routes.draw do
  resources :links do
    resources :comments, :only => [:new, :create]
  end
  resource :session
  resources :subs
  resources :users
end

AjaxDemo::Application.routes.draw do
  root :to => "Lists#index"

  resource :session
  resources :users
  resources :lists
  resources :items, :only => [:create, :destroy]
end

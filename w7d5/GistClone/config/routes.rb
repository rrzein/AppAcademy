SessionsTemplate::Application.routes.draw do
  resources :users, :only => [:new, :create, :show]
  resources :favorites, :only => [:index]
  resources :gists do
    member do
      resource :favorite, :only => [:create, :destroy]
    end
  end
  resource :session, :only => [:new, :create, :destroy]

  root :to => "root#root"
end

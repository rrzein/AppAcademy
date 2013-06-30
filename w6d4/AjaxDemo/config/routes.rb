AjaxDemo::Application.routes.draw do
  root :to => "Users#new"

  resources :secrets
  resource :session
  resource :user, :only => [] do
    resources :secrets, :only => [:new, :create]
  end
  resources :users do
    member do
      resource :friendship, :only => [:create, :destroy]
    end
  end
end

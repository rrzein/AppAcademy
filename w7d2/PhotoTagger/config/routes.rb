PhotoTagger::Application.routes.draw do
  resources :photos, :only => [:show, :create, :update, :destroy, :edit] do
    member do
      resources :tags, :only => [:create, :index]
    end
  end
  resource :session, :only => [:create, :destroy, :new]

  resources :tags, :only => [:destroy]

  resources :users, :only => [:create, :index, :new, :show] do
    member do
      resources :photos, :only => [:index]
    end
  end
end

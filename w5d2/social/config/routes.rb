Social::Application.routes.draw do

  resources :friend_circles, :except => [:destroy]

  resources :posts, :except => [:destroy]

  resource :session, :only => [:new, :create, :destroy]

  resources :users, :only => [:new, :create, :show] do
    member do
      get 'feed'
    end
    resources :friend_circles, :only => [:index, :new, :create]
  end

  resources :up_votes, :only => [:create, :destroy]

end

Newsstand::Application.routes.draw do

  resources :newspapers, :only => [:show, :new, :create] do
    resources :subscription_plans, :only => [:index, :new, :create]
  end

  resources :subscription_plans, :except => [:new, :create]
  resources :users, :only => [:show, :new, :create, :edit, :update]

end

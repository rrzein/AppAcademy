Todoapp::Application.routes.draw do
  resources :projects do
    resources :items, :only => [:new, :create]
  end
  resources :items
end

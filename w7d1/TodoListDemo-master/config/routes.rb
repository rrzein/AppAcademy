AjaxDemo::Application.routes.draw do
  resources :todo_lists, :only => [:create, :destroy, :index, :show, :update] do
    resources :todo_items, :only => [:create, :index]
  end

  resources :todo_items, :only => [:destroy, :show, :update]
  
  root :to => "TodoLists#index"
end

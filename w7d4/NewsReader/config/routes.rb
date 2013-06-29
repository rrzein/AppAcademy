NewReader::Application.routes.draw do
  resources :feeds, only: [:index, :create] do
  	member do
  		get "refresh"
  	end

    resources :entries, only: [:index]
  end

  root to: "feeds#index"
end

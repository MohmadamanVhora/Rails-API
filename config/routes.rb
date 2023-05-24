Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :articles do
        get '/search', to: "articles#search", on: :collection
        get '/page/:page', action: :index, on: :collection
        resources :comments do
          get '/search', to: "comments#search", on: :collection
        end
      end
    end
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  delete "/api/v0/market_vendors/", to: "api/v0/market_vendors#destroy"
  get "/api/v0/markets/search", to: "api/v0/markets#search"
  
  namespace :api do
    namespace :v0 do
      resources :market_vendors, only: [:create]
      resources :vendors, only: [:show, :create, :update, :destroy] do
        resources :markets, only: [:index], controller: 'vendors/markets'
      end
      get "/markets/:id/nearest_atms", to: "market_atms#index"
      resources :markets, only: [:index, :show] do
        resources :vendors, only: [:index], controller: 'markets/vendors'
      end
    end
  end
end

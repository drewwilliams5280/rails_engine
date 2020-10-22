Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do 
        get '/:id/items', to: 'items#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'search#index'
        get '/most_items', to: 'search#index'
      end
      namespace :items do 
        get '/:id/merchant', to: 'merchants#show'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      resources :items
      resources :merchants
      resources :revenue, only: [:index]
    end
  end
end

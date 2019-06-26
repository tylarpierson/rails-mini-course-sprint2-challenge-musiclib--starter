Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :albums, only: [:index, :show] do
        resources :songs, only: [:index]
      end
      resources :artists, only: [:index, :show] do
        resources :albums, only: [:index]
      end
      resources :songs, only: [:index, :show]
      resources :users, only: [:index, :show, :create]
    end
  end
end

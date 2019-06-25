Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :artists, only: [:index, :show] do
        resources :albums, only: [:index], module: :artists
      end
      resources :users, only: [:index, :show, :create]
    end
  end
end

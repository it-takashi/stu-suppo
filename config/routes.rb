Rails.application.routes.draw do
  devise_for :users
  root "tweets#top_page"
  resources :users, only: [:edit, :update,:show] do
    collection do
      post 'update_attribute', to: 'users#update_attribute'
    end
  end
  
  resources :tweets do
    resources :replies, only:[:create, :edit, :update, :destroy]
    collection do
      get 'top_page', to: 'tweets#top_page'
    end
  end
  resources :teaches do
    resources :messages, only: [:create]
    namespace :api do
      resources :messages, only: :index, defaults: { format: 'json' }
    end
    
  end
  resources :callrooms do
    collection do
      get 'update_attribute', to: 'callrooms#update_attribute'
      get :call
    end
  end
  namespace :api do
    resources :callrooms, only: [:index, :new], defaults: { format: 'json' }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

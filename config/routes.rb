Rails.application.routes.draw do
  devise_for :users
  root "tweets#index"
  resources :users, only: [:edit, :update]
  
  resources :tweets do
    resources :replies, only:[:create, :edit, :update, :destroy]
  end
  resources :teaches do
    resources :messages, only: [:create]
    namespace :api do
        resources :messages, only: :index, defaults: { format: 'json' }
    end
    
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

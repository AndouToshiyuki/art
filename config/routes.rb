Rails.application.routes.draw do
  root to: 'homepages#index'
  
  get 'top', to: 'toppages#index'
  get 'posting', to: 'posting#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  resources :tags, only: [:index,:show]
  resources :favorites, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :posts, only: [:create, :destroy, :edit, :update]
  resources :users, only: [:index,:show, :new, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
end

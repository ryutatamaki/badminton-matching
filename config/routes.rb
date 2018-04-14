Rails.application.routes.draw do
  root 'toppages#index'
  
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  get 'signup' => 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :favorites
    end
  end
  

  resources :microposts, only: [:index, :show, :create, :destroy]
  
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :messages, only: [:create, :destroy]
end

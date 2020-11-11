Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update] do
    collection do
      patch 'quit'
      get 'out'
    end
  end
  resources :tweets, except: [:new] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  
  root to: 'homes#top'
  
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    # sessions: 'users/sessions'
    # passwords: 'users/passwords'
  }
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    post 'users/guest_sign_up', to: 'users/registrations#new_guest'
  end
  
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

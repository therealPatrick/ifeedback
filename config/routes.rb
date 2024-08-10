Rails.application.routes.draw do
  root 'dashboard#index'
  resources :feedbacks

  devise_for :users
  
  resources :boards do
    resources :feedbacks do
      resources :comments, only: [:create, :destroy]
      member do
        post 'upvote'
        post 'downvote'
      end
    end
  end
  
  get 'dashboard', to: 'dashboard#index'
end
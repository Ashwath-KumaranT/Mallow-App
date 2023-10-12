Rails.application.routes.draw do
  devise_for :users
  root 'topics#index'
  resources :topics do
    resources :posts do
      patch 'mark_as_read', on: :member
      resources :comments do
        resources :user_comment_ratings
      end
      resources :ratings, only: [:create]
    end
  end

  resources :tags do
    member do
      get 'posts', to: 'tags#posts', as: 'posts'
    end
  end

  get '/all_posts', to: 'posts#all_posts'
  resources :posts
end

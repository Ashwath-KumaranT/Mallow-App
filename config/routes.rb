Rails.application.routes.draw do
  devise_for :users

  resources :topics do
    resources :posts do
      patch 'mark_as_read', on: :member
      resources :comments
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

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :topics, except: [:show]
  # get 'topics/:id', to: 'topics#show', as: :topic
  # delete 'topics/:id', to: 'topics#destroy', as: :delete_topic

end

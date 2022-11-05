Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"

  resources :articles
  resources :music_tags, only: %i[index show]
  resources :musics, only: %i[index show new create edit update]
  resources :actors, only: %i[index show update]

  namespace :api do
    resources :articles, only: :create
  end
end

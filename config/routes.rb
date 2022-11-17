Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "articles#index"

  resources :articles
  resources :music_tags, only: %i[index show]
  resources :musics, only: %i[index show new create edit update]
  resources :actor_tags, only: %i[index show update]
  resources :actors, only: %i[index show new create edit update]

  namespace :api do
    resources :articles, only: :create
  end

  namespace :shared do
    resources :musics, only: %i[index show new create]
    resources :actors, only: %i[index update new create destroy]
  end
end

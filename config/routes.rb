require 'sidekiq/web'

Rails.application.routes.draw do
  resources :decks do
    collection do
      get :current
    end
  end

  resources :cards

  resources :packs, only: [:update]

  resources :drafts do
    collection do
      get :current
    end

    member do
      get :pack
      get :deck
      get :drafter
      get :drafters
      post :start
      post :leave
    end
  end

  resources :drafters

  resources :sets

  mount Sidekiq::Web => '/sidekiq'
end

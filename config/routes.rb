Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :banks
  end

  resources :banks do
    resources :words, only: [:update, :index, :create, :destroy]
  end

  resources :banks do
    resources :drills, only: [:index]
  end

  resources :words, only: [:index]

  root 'users#index'

  namespace :api do
    namespace :v1 do
        resources :words, only: [:create, :index, :update]
    end
  end
end

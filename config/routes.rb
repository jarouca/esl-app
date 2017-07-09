Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    resources :banks
  end

  resources :banks do
    resources :words
  end

  resources :banks do
    resources :drills
  end



  resources :words, only: [:index]

  root 'users#index'
end

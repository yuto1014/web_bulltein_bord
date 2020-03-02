Rails.application.routes.draw do

  root 'users/posts#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  namespace :users do
    resources :posts do
    	resources :comments, only: [:create, :destroy]
    end
    resources :categories
    resources :users

    get "search" => "posts#search", as: 'search'
    get "category/:id" => "posts#category"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  namespace :users do
    get 'posts/index'
    get 'posts/show'
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

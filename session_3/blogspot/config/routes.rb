Rails.application.routes.draw do
  root to: 'articles#index'
  resources :users
  resources :articles
  resources :sessions, only: [:new, :create, :destory]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

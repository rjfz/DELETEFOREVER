Rails.application.routes.draw do
  get 'welcome/index'

  resources :articles do
    resources :comments
  end

  resources :users, only: %i[new create]

  get 'signup', action: :new, controller: :users
  post 'signup', action: :create, controller: :users

  post 'signin', action: :signin, controller: :signin
  get 'signin', action: :index, controller: :signin

  get 'signout', action: :signout, controller: :users

  resources :signup, only: %i[new create]

  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

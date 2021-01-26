# frozen_string_literal: true

Rails.application.routes.draw do
  get 'welcome/index'
  get 'options', action: :index, controller: :options
  get 'change_password', action: :change_password, controller: :options
  patch 'update_password/:id', action: :update_password, controller: :users, as: :update_password

  resources :articles do
    resources :comments
  end

  resources :users, only: %i[new create update]

  get 'signup', action: :new, controller: :users
  post 'signup', action: :create, controller: :users

  post 'signin', action: :signin, controller: :signin
  get 'signin', action: :index, controller: :signin

  get 'signout', action: :signout, controller: :users

  resources :signup, only: %i[new create]

  scope module: 'admin', path: 'admin', as: 'admin' do
    resources :users
    post '/users/ban/:id', action: :ban_time, controller: :users, as: :ban_time
    post '/users/unban/:id', action: :unban_user, controller: :users, as: :unban_user
  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

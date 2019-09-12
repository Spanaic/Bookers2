Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#new'
  get 'about', to: 'users#about'
  # コントローラ名は正しく複数形でね！
  # uninitialized constant UserController

  resources :users, only: [:show, :new, :edit, :index, :update] do

  end

  resources :books, only: [:index, :show, :edit, :create, :destroy, :update] do

  end
end

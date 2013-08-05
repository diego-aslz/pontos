Pontos::Application.routes.draw do
  match 'user/edit' => 'users#edit', :as => :edit_current_user

  match 'signup' => 'users#new', :as => :signup

  match 'logout' => 'sessions#destroy', :as => :logout

  match 'login' => 'sessions#new', :as => :login

  resources :sessions

  resources :users

  resources :periods

  root to: 'periods#index'
end

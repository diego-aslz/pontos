Pontos::Application.routes.draw do
  resources :periods

  root to: 'periods#index'
end

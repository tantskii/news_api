Rails.application.routes.draw do
  resources :news
  resources :users
  resource :session, only: [:create, :destroy]
end

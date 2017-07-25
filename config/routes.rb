Rails.application.routes.draw do
  resources :news
  resources :users, except: [:index, :show]
  resource :session, only: [:create, :destroy]
end

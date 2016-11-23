Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root 'posts#index'
  end
  root 'static_pages#home'

  resources :posts, except: [:index]
end

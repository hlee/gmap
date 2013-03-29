Gmap::Application.routes.draw do
  resources :locations


  resources :projects do
    get 'list', on: :collection
    get 'fetch', on: :collection
  end


  authenticated :user do
    root :to => "projects#index"
  end
  root :to => "home#list"
  devise_for :users
  resources :users
end
Rails.application.routes.draw do
  root 'hello_world#index'

  resources :patients, only: [:show, :index, :create, :update], param: :identifier
end

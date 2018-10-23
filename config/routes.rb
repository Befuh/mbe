Rails.application.routes.draw do
  root 'hello_world#index'

  resources :patients, only: [:show, :index, :create], param: :identifier
end

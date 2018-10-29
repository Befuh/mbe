Rails.application.routes.draw do
  root 'hello_world#index'

  resources :patients, only: [:show, :index, :create], param: :identifier do
    resources :consultations, only: [:index, :show, :create, :update]
  end
end

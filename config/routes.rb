Rails.application.routes.draw do
  devise_for :users

  post '/operations/filter', to: 'operations#filter'

  resources :operations do
  	get 'select_categories'
  	post 'filter', on: :collection
  end

  resources :categories

  get 'page/index'

  root 'page#index'

end

Rails.application.routes.draw do
  devise_for :users

get 'operations/ajax_categories'

  resources :operations

  resources :categories  

  get 'page/index'

	root 'page#index'

end

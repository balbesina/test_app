Rails.application.routes.draw do
  devise_for :users

  resources :operations do
  	get 'select_categories'
  end

  resources :categories

  get 'page/index'

	root 'page#index'

end

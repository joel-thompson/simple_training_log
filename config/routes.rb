Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	root 'welcome#index'
	get  '/signup',  to: 'users#new'
	post '/signup',  to: 'users#create'
  get	'/login',	to:	'sessions#new'
  post '/login',	to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

	resources :users

  resources :account_activations, only: [:edit, :new]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]

  scope module: :martial_arts do
    resources :martial_arts
  end

  resources :techniques
  resources :rounds
  resources :body_weight_records, only: [:create, :index, :destroy]
end

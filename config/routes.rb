Rails.application.routes.draw do

	root 'posts#index'

  resources :posts do
  	resources :comments
  end

	devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "logout",   :to => "devise/sessions#destroy"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

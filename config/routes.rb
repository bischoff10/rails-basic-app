Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users do
    resource :profile
    resources :posts
    # resource :posts, only: :index
  end
  get 'about', to: 'pages#about'
  get 'rules', to: 'pages#rules'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  get 'feed', to: 'posts#feed'
end

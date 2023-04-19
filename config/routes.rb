Rails.application.routes.draw do
  devise_for :users do get '/users/sign_out' => 'devise/sessions#destroy' 
  end
  #devise_for :users 
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root'welcome#home'
  get 'about', to: 'welcome#about'
  resources :articles

  
  #get 'signup', to: 'users#new'
  #resources :users, except: [:new]
  #get 'login', to: 'sessions#new'
  #post 'login', to: 'sessions#create'
  #get 'logout', to: 'device/sessions#destroy'
  # Defines the root path route ("/")
  # root "articles#index"
end





























  
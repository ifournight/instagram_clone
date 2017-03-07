Rails.application.routes.draw do
  # Custom
  get    'signup', to: 'users#new'
  post   'signup', to: 'users#create'
  get    'login',  to: 'sessions#new'
  post   'login',  to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # RESTful
  resources :users do
    member do
      get 'activate', to: 'users#activate'
    end
  end

  root to: 'users#index'

  # Advanced
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

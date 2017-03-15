Rails.application.routes.draw do
  # DEVISE
  devise_for :users,
             controllers: {
               passwords: 'users/passwords',
               confirmations: 'users/confirmations'
             },
             only: [:passwords, :confirmations]

  devise_scope :user do
    get    'sign_up',  to: 'users/registrations#new'
    post   'sign_up',  to: 'users/registrations#create'
    get    'sign_in',  to: 'users/sessions#new'
    post   'sign_in',  to: 'users/sessions#create'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

  get '/:name', to: 'users#show'

  resources :users, only: [] do
    collection do
      post   :follow, to: 'users#follow'
      delete :follow, to: 'users#unfollow'
    end
    resources :posts, only: [:new, :create]
  end

  resources :posts, only: [:update, :destroy] do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:update, :destroy]

  root to: 'home#index'
  # Advanced
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

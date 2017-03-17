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

  get '/:name/followers', to: 'users#followers', as: 'user_followers'
  get '/:name/following', to: 'users#following', as: 'user_following'

  resources :users, only: [:edit, :update] do
    collection do
      post   :follow, to: 'users#follow'
      delete :follow, to: 'users#unfollow'
    end

    member do
      post   :like, to: 'users#like'
      delete :like, to: 'users#unlike'
    end

    resources :posts, only: [:new, :create]
  end

  resources :posts, only: [:update, :destroy] do
    resources :comments, only: [:new, :create]
  end

  resources :comments, only: [:update, :destroy]

  # post   :like_action, to: 'users#like', as: 'user_like'
  # delete :like_action, to: 'users#unlike', as: 'user_unlike'

  root to: 'home#index'
  # Advanced
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

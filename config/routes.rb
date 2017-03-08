Rails.application.routes.draw do
  # DEVISE
  devise_for :users,
             controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations' }

  devise_scope :user do
    get    'sign_up',  to: 'users/registrations#new'
    get    'sign_in',  to: 'users/sessions#new'
    delete 'sign_out', to: 'users/sessions#destroy'
  end

  root to: 'home#index'

  # Advanced
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

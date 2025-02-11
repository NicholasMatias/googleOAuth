Rails.application.routes.draw do
  # Root path
  root 'books#index'

  # Devise routes for admin authentication
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks', sessions: 'admins/sessions'}
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    get 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  # Resources
  resources :user_books
  resources :users
  resources :books do
    member do
      get :delete
    end
  end
end


#http://127.0.0.1:3000/
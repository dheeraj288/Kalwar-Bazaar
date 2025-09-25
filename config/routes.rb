Rails.application.routes.draw do
  root 'pages#home'
  get 'start_page', to: 'pages#start_page', as: 'start_page'

  devise_for :users, controllers: { 
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  namespace :users do
    get  'verify_otp', to: 'otp#new', as: 'verify_otp'
    post 'verify_otp', to: 'otp#create'
    post 'resend_otp',  to: 'otp#resend', as: 'resend_otp'
  end
end

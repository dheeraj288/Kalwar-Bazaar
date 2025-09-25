Rails.application.routes.draw do
  root 'pages#home'
  get 'start_page', to: 'pages#start_page', as: 'start_page'
  devise_for :users
end

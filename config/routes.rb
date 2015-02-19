Rails.application.routes.draw do

  ## Root
  root "site#index"

  ## Generated Resource Routes
  resources :users

  ## Custom Routes
  get "login" => "sessions#new", as: :login
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy", as: :logout

  get "about" => "site#about", as: :about

  ## Custom Server Errors (http://easyactiverecord.com/blog/2014/08/19/redirecting-to-custom-404-and-500-pages-in-rails/)
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  ## Backup for Custom Server Errors (http://jerodsanto.net/2014/06/a-step-by-step-guide-to-bulletproof-404s-on-rails/)
  get "*any", to: "errors#file_not_found", via: :all
  
  get 'errors/file_not_found'
  get 'errors/unprocessable'
  get 'errors/internal_server_error'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end

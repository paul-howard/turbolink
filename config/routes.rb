Rails.application.routes.draw do

  ## Root
  root "site#index"

  ## Custom Routes
  # post "login" => "sessions#create"

  get "about" => "site#about", as: :about
  get "terms" => "site#terms", as: :terms
  get "privacy" => "site#privacy", as: :privacy
  get "faq" => "site#faq", as: :faq
  get "thanks" => "site#thanks", as: :thanks

  get "getstarted" => "validations#new", as: :get_started
  get "validate" => "validations#create", as: :validate

  # Routes for Devise gem
  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks',
                                       sessions: 'sessions' }
                     # :path_names  => { sign_in: 'login', sign_out: 'logout'}
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  get "login" => "sessions#new", as: :login
  get "logout" => "sessions#destroy", as: :logout

  ## Generated Resource Routes
  resources :users
  resources :validations
  resources :invitations

  ## Custom Server Errors (http://easyactiverecord.com/blog/2014/08/19/redirecting-to-custom-404-and-500-pages-in-rails/)
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  get 'errors/file_not_found'
  get 'errors/unprocessable'
  get 'errors/internal_server_error'

  ## Backup for Custom Server Errors (http://jerodsanto.net/2014/06/a-step-by-step-guide-to-bulletproof-404s-on-rails/)
  # get "*any", to: "errors#file_not_found", via: :all

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

end

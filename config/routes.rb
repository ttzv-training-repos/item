Rails.application.routes.draw do
  resources :holidays, only: [:index]
  resources :holiday_requests
  resources :employees
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'item#index'

  get 'item', to: 'item#index'
  scope '/item' do
    resources :ad_users, only: [:index] do
      resource :ad_user_details
    end
    resources :user_holders, only: [:index]
    resources :signatures, only: [:index]
    resources :sms_gateway, only: [:index]
    resources :offices, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :c_box, only: [:index]
    resources :settings, only: [:index]
    resources :mails, only: [:index]
    resources :templates do
      resources :itemtags, only: [:index, :edit, :destroy] do
        resource :tag_custom_mask
      end
      post '/', to: 'templates#tag_edit'
    end
    resources :itemtags
    get '/ad_users/reload', to: 'ad_users#reload'
  end

  post '/item/user_holders', to: 'user_holders#process_request'

  scope 'item/settings' do
    get '/autobind', to: 'settings#run_autobinder', as: 'autobind'
    post '/',  to: 'settings#process_request'
    post '/update_smtp_settings', to: 'settings#update_smtp_settings'
    patch '/update_smtp_settings', to: 'settings#update_smtp_settings'
  end

  scope 'item/mails' do
    post '/upload', to: 'mails#upload', as: 'mails_upload'
    post '/send_request', to: 'mails#send_request'
    get '/templates_data', to: 'mails#templates_data'
    post '/progress', to: 'mails#progress'
  end

get '/user/become/:id', to: 'users#become', as: 'become_user'

  

end

# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :inboxes
  resources :holidays, only: [:index]
  resources :holiday_requests
  resources :employees
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'item#index'

  get 'item', to: 'item#index'
  scope '/item' do
    resources :ad_users do
      resource :ad_user_details
    end
    resources :user_holders, only: [:index]
    resources :signatures, only: [:index] do
      get :download
    end
    resources :sms_gateway, only: [:index]
    resources :offices, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :c_box, only: [:index]
    resources :settings, only: [:index]
    resources :mails, only: [:index]
    resources :templates do
      resources :itemtags, only: [:index, :edit, :destroy] do
        resource :tag_custom_mask
      end
      post '/tag_edit', to: 'templates#tag_edit', as: 'tag_edit'
    end
    resources :itemtags
  end

  post '/item/user_holders', to: 'user_holders#process_request'

  scope 'item/settings' do
    get '/autobind', to: 'settings#run_autobinder', as: 'autobind'
    get '/sync_ldap', to: 'settings#sync_ldap', as: 'sync_ldap'
    post '/',  to: 'settings#process_request'
    post '/update_smtp_settings', to: 'settings#update_smtp_settings'
    patch '/update_smtp_settings', to: 'settings#update_smtp_settings'
    post '/update_ldap_settings', to: 'settings#update_ldap_settings'
    patch '/update_ldap_settings', to: 'settings#update_ldap_settings'
    post '/update_app_settings', to: 'settings#update_app_settings'
    patch '/update_app_settings', to: 'settings#update_app_settings'
    post '/update_sms_settings', to: 'settings#update_sms_settings'
    patch '/update_sms_settings', to: 'settings#update_sms_settings'
    post '/update_gmail_authorization', to: 'settings#update_gmail_authorization'
  end

  scope 'item/mails' do
    post '/send_request', to: 'mails#send_request'
  end

  scope 'item/sms_gateway' do
    post '/send_request', to: 'sms_gateway#send_request'
  end

  scope 'item/signatures' do
    post '/send_request', to: 'signatures#send_request'
  end

  scope 'item/templates' do
    post '/upload', to: 'templates#upload', as: 'upload_template'
  end

get '/user/become/:id', to: 'users#become', as: 'become_user'

  

end

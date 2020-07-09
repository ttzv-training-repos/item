Rails.application.routes.draw do
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
    get '/ad_users/reload', to: 'ad_users#reload'
  end


  post '/item/user_holders', to: 'user_holders#process_request'
  # scope '/item/user_holders' do
  #   # post '/select', to: 'user_holders#select'
  #   # post '/clear', to: 'user_holders#clear'
  #   # get '/qty', to: 'user_holders#qty'
  #   # get '/content', to: 'user_holders#content'
  # end

  scope 'item/settings' do
    get '/autobind', to: 'settings#run_autobinder', as: 'autobind'
    post '/',  to: 'settings#process_request'
    
  end

  scope 'item/mails' do
    post '/upload', to: 'mails#upload', as: 'mails_upload'
    post '/send_request', to: 'mails#send_request'
    get '/templates_data', to: 'mails#templates_data'
  end
end

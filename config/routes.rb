Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'item#index'

  get 'item', to: 'item#index'
  scope '/item' do
    resources :ad_users, only: [:index]
    resources :user_holders, only: [:index]
    get '/ad_users/reload', to: 'ad_users#reload'
  end

  scope '/item/user_holders' do
    post '/select', to: 'user_holders#select'
    post '/clear', to: 'user_holders#clear'
    get '/qty', to: 'user_holders#qty'
    get '/content', to: 'user_holders#content'
  end

  resources :mails, only: [:index]
end

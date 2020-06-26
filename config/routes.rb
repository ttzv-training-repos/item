Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'item#index'
  get 'item', to: 'item#index'
  get 'item/ad_users', to: 'ad_users#index'
  get 'item/ad_users/reload', to: 'ad_users#reload'
  post 'item/ad_users/all', to: 'item#all_users_filtered'
  post 'item/user_holders/select', to: 'user_holders#select'
  post 'item/user_holders/clear', to: 'user_holders#clear'
  get 'item/user_holders/qty', to: 'user_holders#qty'
  get 'item/user_holders/content', to: 'user_holders#content'
  get 'item/user_holders', to: 'user_holders#index'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'item#index'
  get 'item', to: 'item#index'
  get 'item/ad_users', to: 'ad_users#index'
  get 'item/ad_users/all', to: 'item#all_users'
  get 'item/ad_users/reload', to: 'ad_users#reload'
  post 'item/ad_users/all', to: 'item#all_users_filtered'
end

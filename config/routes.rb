Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'item', to: 'item#index'
  get 'item/ad_users', to: 'ad_users#index'
  get 'item/ad_users/all', to: 'item#all_users'
  post 'item/ad_users/all', to: 'item#all_users_filtered'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :item
  get 'item/users/all', to: 'item#all_users'
end

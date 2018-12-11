Rails.application.routes.draw do
  devise_for :users
  root :to => 'records#index'
  resources :records
  get 'records_data', to: "charts#records_data", as: "records_data"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

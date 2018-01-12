Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

      resources :chart_account_classifications
      resources :chart_accounts
      resources :entries, only: :create
      resources :tag_kinds
      resources :tags
    end
  end
end

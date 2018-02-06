Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

      resources :attachments, only: :create
      resources :chart_account_classifications
      resources :chart_accounts
      resources :entries, except: [:show, :new, :edit] do
        member do
          post :confirm
        end

        collection do
          delete :destroy_group, path: "/"
        end
      end

      resources :tag_kinds
      resources :tags
      resources :transactions
      resources :users, only: [] do
        collection do
          get :me
        end
      end
    end
  end
end

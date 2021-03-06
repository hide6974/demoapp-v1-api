Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # users
      resources :users, only:[] do
        get :current_user, action: :show, on: :collection
      end

      # 追加
      # login, logout
      resources :user_token, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
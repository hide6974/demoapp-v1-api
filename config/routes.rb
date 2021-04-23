Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # 追加
       resources :users, only:[:index]
      # 削除
      # resources :hello, only:[:index]
    end
  end
end
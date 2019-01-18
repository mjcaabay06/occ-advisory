Rails.application.routes.draw do
  root :to => 'application#index'
  namespace :admin do
    resources :users
    resources :user_department, path: 'departments'

    get '/login' => 'home#login'
    post '/login-auth' => 'home#login_auth'
    get '/logout' => 'home#logout'
    get '/check-account' => 'home#check_account'

    resources :advisory do
      collection do
        get :review_advisory, path: '/review-advisory/:sid'
        get :send_advisory, path: '/send-advisory/:sid'
        get :inbox, path: '/inbox'
        get :inbox_filter, path: '/filter'
        get :created_filter, path: '/created-filter'
        post :create_reply
        get :print, path: '/print/:sid'
        get :forward, path: '/forward'
      end
    end

    get '/memo/check-account' => 'memo#check_account'
    resources :memo do
      collection do
        get :review_memo, path: '/review-memo/:sid'
        get :send_memo, path: '/send-memo/:sid'
        get :memo_filter, path: '/filter'
        get :created_filter, path: '/created-filter'
        get :inbox, path: '/inbox'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

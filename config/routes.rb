Rails.application.routes.draw do
  root :to => 'application#index'
  namespace :admin do
    get '/' => 'home#index'
    get '/login' => 'home#login'
    post '/login-auth' => 'home#login_auth'
    get '/logout' => 'home#logout'
    # resources :home, path: '/' do
    #   collection do
    #     get :login, path: '/login'
    #     post :login_auth, path: '/login-auth'
    #     get :logout
    #     get :new, path: '/new-advisory'
    #     get :memo_filters, path: '/memo-filters'
    #     get :memo_info, path: '/memo-info'
    #   end
    # end

    resources :advisory do
      collection do
        get :review_advisory, path: '/review-advisory/:sid'
        get :send_advisory, path: '/send-advisory/:sid'
        get :inbox, path: '/inbox'
        get :created_filter, path: '/created-filter'
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

Rails.application.routes.draw do
  root :to => 'application#index'
  namespace :admin do
    resources :home, path: '/' do
      collection do
        get :login, path: '/login'
        get :new, path: '/new-advisory'
        get :memo_filters, path: '/memo-filters'
        get :memo_info, path: '/memo-info'
      end
    end

    resources :advisory, only: [:new]

    get '/memo/check-account' => 'memo#check_account'
    resources :memo
    # get 'login' => 'home#login'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  namespace :admin do
    get 'memo/index'
  end
  root :to => 'application#index'
  namespace :admin do
    resources :home, path: '/' do
      collection do
        get :login, path: '/login'
        get :new, path: '/new-advisory'
      end
    end

    resources :memo
    # get 'login' => 'home#login'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

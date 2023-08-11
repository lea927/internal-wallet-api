Rails.application.routes.draw do
  resource :session, only: [:new, :create, :destroy], path_names: { new: 'login' }
  resources :users, only: [:show]
  resources :transactions, only: [:create, :new, :show] do
    collection do
      get 'withdraw_form'
      post 'withdraw'
    end
  end
end

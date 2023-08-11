Rails.application.routes.draw do
  resources :users, only: [:show]
  resources :transactions, only: [:create, :new, :show] do
    collection do
      get 'withdraw_form'
      post 'withdraw'
    end
  end
end

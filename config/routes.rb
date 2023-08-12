Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'
  resource :session, only: [:create, :destroy]

  resources :users, only: [:show]
  resources :transactions, only: [:create, :new, :show] do
    collection do
      get 'withdraw_form'
      post 'withdraw'
    end
  end

  root to: "application#root_redirect"
end

Rails.application.routes.draw do
  get 'login', to: 'sessions#new', as: 'login'
  resource :session, only: [:create, :destroy]

  resources :transactions, only: [:create, :new, :show] do
    collection do
      get 'withdraw_form'
      post 'withdraw'
    end
  end

  get '/:id', to: 'users#show', as: 'user_profile'
  root to: "application#root_redirect"
end

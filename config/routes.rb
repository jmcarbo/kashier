Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "welcome#index"

  resources :products

  resource :cash_register, only: [ :show, :update, :destroy ] do
    resources :cash_register_lines
  end
end

Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'pages#landing_page'
  resources :items do
    collection do
      get :my_items
    end
    member do
      get :inc_quantity
      get :dec_quantity
    end
  end
end

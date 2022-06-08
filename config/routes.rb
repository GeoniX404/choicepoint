Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :choice_points, only: %i[index show new create] do
    resources :options, only: %i[create] do
      member do
        post :vote
      end
    end
  end
end

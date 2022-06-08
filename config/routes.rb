Rails.application.routes.draw do
  devise_for :users
  root to: 'choice_points#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :choice_points, only: %i[index show new create] do
    resources :options, only: %i[index new create]
    member do
      patch :vote
    end
  end
end

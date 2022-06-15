Rails.application.routes.draw do
  devise_for :users
  root to: 'choice_points#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/my_choice_points", to: "choice_points#my_choice_points", as: :my_choice_points
  resources :choice_points, only: %i[index show new create update] do
    resources :options, only: %i[index new create]
    member do
      patch :vote
      patch :feedback
    end
  end
end

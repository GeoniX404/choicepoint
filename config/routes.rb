Rails.application.routes.draw do
  devise_for :users
  root to: 'choice_points#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/active", to: "choice_points#active", as: :active
  get "/past", to: "choice_points#past", as: :past
  # get "/:id/feedback", to: "choice_points#feedback", as: :feedback
  resources :choice_points, only: %i[index show new create update] do
    resources :options, only: %i[index new create]
    member do
      patch :vote
      patch :feedback
    end
  end
end

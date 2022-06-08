Rails.application.routes.draw do
  devise_for :users
  root to: 'choice_points#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :choice_points, only: %i[index show new create] do
<<<<<<< HEAD
    resources :options, only: %i[index new create]
=======
    resources :options, only: %i[create] do
      member do
        post :vote
      end
    end
>>>>>>> master
  end
end

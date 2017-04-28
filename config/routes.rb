Rails.application.routes.draw do
  resources :users
  resources :candidates do
      member do
        post :vote
      end
   end
#   get "/", to: redirect('/candidates')
  root "candidates#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

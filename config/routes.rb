Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/team', to:'gossips#team'
  get '/contact', to: 'gossips#contact'

  resources :gossips do
    resources :users, only: [:show]
    resources :comments
    resources :likes, only: [:create, :destroy]
  end

  resources :users
  resources :sessions, only: [:new, :create, :destroy, :show]

  post '/gossips/:id/edit', to: 'gossips#edit'
  resources :cities, only: [:show]

end
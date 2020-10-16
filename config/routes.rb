Rails.application.routes.draw do
  root 'searches#about'

  get 'search', action: :search, controller: 'searches'

  #resources :searches
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

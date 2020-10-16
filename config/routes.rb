Rails.application.routes.draw do
  root 'search#about'

  get 'search', action: :search, controller: 'search'

  get '*path' => redirect('/')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

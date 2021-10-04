Rails.application.routes.draw do
  resources :messages
  resources :posts
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :requests
  resources :fields
  
  devise_for :students, controllers: {
    sessions: 'students/sessions'
  }
  devise_for :universities, controllers: {
    sessions: 'universities/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

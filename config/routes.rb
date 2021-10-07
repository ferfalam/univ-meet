Rails.application.routes.draw do
  root to: 'landing#indexuniversity'
  resources :messages
  resources :posts
  
  resources :requests
  resources :fields
  
  devise_for :students, controllers: {
    registrations: 'students/registrations',
    sessions: 'students/sessions'
  }
  devise_for :universities, controllers: {
    registrations: 'universities/registrations',
    sessions: 'universities/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  root to: 'top#index'
  resources :messages
  resources :posts
  resources :requests
  
  namespace :admins do
    resources :universities, only: [:index, :destroy]
    post "/universities/valid", to: "universities#valid"
    post "/universities/unvalid", to: "universities#unvalid"
    post "/universities/destroymail", to: "universities#destroymail"
  end
  
  get '/universities/landing/', to: "landing#indexuniversity"
  namespace :universities do
    resources :students, only: [:index, :destroy]
    post "/students/valid", to: "students#valid"
    post "/students/unvalid", to: "students#unvalid"
    post "/students/destroymail", to: "students#destroymail"
    resources :fields, only: [:index, :create, :destory]
    resources :requests, only: [:index, :destory]
  end
  
  devise_for :students, controllers: {
    passwords: 'students/password',
    registrations: 'students/registrations',
    sessions: 'students/sessions'
  }
  devise_for :universities, controllers: {
    passwords: 'universities/password',
    registrations: 'universities/registrations',
    sessions: 'universities/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

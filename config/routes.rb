Rails.application.routes.draw do
  root to: 'top#index'
  
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
    resources :fields, only: [:index, :create, :destroy]
    resources :requests, only: [:index, :create, :destroy]
  end
  
  get '/students/landing/', to: "landing#indexstudent"
  namespace :students do
    post "/posts/favorite/:id", to: "posts#favorite"
    post "/posts/unfavorite/:id", to: "posts#unfavorite"
    resources :messages, only: [:index]
    resources :requests, only: [:new, :create]
    resources :posts, only: [:index, :show, :create, :update, :destroy]
    resources :comments, only: [:create, :destroy]
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

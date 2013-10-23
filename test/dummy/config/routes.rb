Rails.application.routes.draw do

  devise_for :users
  mount Bookings::Engine => "/bookings"

  resources :patients
  resources :doctors

  root :to => "patients#index"

end

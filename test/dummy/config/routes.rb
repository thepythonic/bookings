Rails.application.routes.draw do

  mount Bookings::Engine => "/bookings"

  resources :patients
  resources :doctors
end

Bookings::Engine.routes.draw do
  resources :template_slots

  resources :appointments
  get 'appointments/for/:reservable', to: 'appointments#appointments_for_reservable'
  
  get 'appointments/customers/:customer', to: 'appointments#appointments_for_customer'
  get 'appointments/start/:start/end/:end', to: 'appointments#within_date_range'


  resources :template_solts

end

Bookings::Engine.routes.draw do
  resources :time_slots

  resources :template_slots

  resources :appointments

  get 'template/slots', to: 'template_slots#slots'
  get 'appointments/for/:reservable', to: 'appointments#appointments_for_reservable'
  
  get 'appointments/customers/:customer', to: 'appointments#appointments_for_customer'
  get 'appointments/start/:start/end/:end', to: 'appointments#within_date_range'


end

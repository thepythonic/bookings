Bookings::Engine.routes.draw do
  resources :time_slots

  resources :template_slots

  resources :appointments

  post 'template/copy_to_time_slots', to: 'template_slots#copy_to_time_slots'
  
  get 'template/slots', to: 'template_slots#slots'
  get 'appointment/slots', to: 'appointments#slots'
  get 'appointments/for/:reservable', to: 'appointments#appointments_for_reservable'
  
  get 'appointments/customers/:customer', to: 'appointments#appointments_for_customer'
  get 'appointments/start/:start/end/:end', to: 'appointments#within_date_range'


end

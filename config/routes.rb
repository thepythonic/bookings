Bookings::Engine.routes.draw do
  resources :time_slots

  resources :appointments

  #get time slots
  get 'time/slots', to: 'time_slots#slots'
  #get appointment slots
  get 'appointment/slots', to: 'appointments#slots'
  get 'customers/find', to: 'customers#find'

  get 'appointments/for/:reservable', to: 'appointments#appointments_for_reservable'
  
  get 'appointments/customers/:customer', to: 'appointments#appointments_for_customer'
  get 'appointments/start/:start/end/:end', to: 'appointments#within_date_range'


end

Bookings::Engine.routes.draw do
  resources :time_slots

  
  get 'customers/find', to: 'customers#find'

  #get time slots
  get 'time/slots', to: 'time_slots#slots'
  #get appointment slots
  get 'appointments/slots', to: 'appointments#slots'
  
  resources :reservable do
    resources :appointments
  end

  get 'appointments/for/:reservable_id', to: 'appointments#appointments_for_reservable'
  
  get 'appointments/customers/:customer', to: 'appointments#appointments_for_customer'
  get 'appointments/start/:start/end/:end', to: 'appointments#within_date_range'

  resources :appointments

end

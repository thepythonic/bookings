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

  get '/reservable/:reservable_id/appointments_slots/', to: 'appointments#appointments_for_reservable', as: :reservable_appointments_slots
  
  get 'appointments/customers/:customer', to: 'appointments#appointments_for_customer'
  get 'appointments/start/:start/end/:end', to: 'appointments#within_date_range'


end

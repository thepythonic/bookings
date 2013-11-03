Bookings::Engine.routes.draw do
	
	get 'appointments/welcome', to: "appointments#welcome", as: :appointments_welcome

  resources :time_slots
  
  get 'customers/find', to: 'customers#find'

  #get time slots
  get 'time/slots', to: 'time_slots#slots'
  
  resources :reservable do
    resources :appointments
  end

  get '/reservable/:reservable_id/appointments_slots/', to: 'appointments#appointments_for_reservable', as: :reservable_appointments_slots

  get '/my/appointments', to: 'appointments#my_appointments'

end

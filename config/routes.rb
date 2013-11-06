Bookings::Engine.routes.draw do
	
	get 'appointments/welcome', to: "appointments#welcome", as: :appointments_welcome
  
  get 'customers/find', to: 'customers#find'

  resources :time_slots

  #get time slots
  
  
  resources :reservable do
    resources :appointments
    resources :time_slots
  end

  get '/reservable/:reservable_id/appointments_slots/', to: 'appointments#appointments_for_reservable', as: :reservable_appointments_slots
  get '/reservable/:reservable_id/configure_slots', to: 'time_slots#configure_slots', as: :reservable_configure_slots

  get '/my/appointments', to: 'appointments#my_appointments', as: 'my_appointments'
  get '/my/time_slots', to: 'time_slots#my_time_slots', as: 'my_time_slots'

end

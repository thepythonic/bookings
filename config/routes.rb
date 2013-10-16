Bookings::Engine.routes.draw do
  resources :appointments

  get 'appointments/employees/:employee', to: 'appointments#appointments_for_employee'
  get 'appointments/customers/:customer', to: 'appointments#appointments_for_customer'
  get 'appointments/start/:start/end/:end', to: 'appointments#within_date_range'

end

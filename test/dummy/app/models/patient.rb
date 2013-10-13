class Patient < User

  has_many :appointments, class_name: 'Bookings::Appointment', foreign_key: 'customer_id'
  
end
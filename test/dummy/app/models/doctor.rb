class Doctor < User

  has_many :appointments, class_name: 'Bookings::Appointment', foreign_key: 'employee_id'
  
end
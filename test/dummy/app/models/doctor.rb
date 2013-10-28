class Doctor < User

  has_many :appointments, class_name: 'Bookings::Appointment', foreign_key: 'reservable_id'
  has_many :time_slots, class_name: 'Bookings::TimeSlot', foreign_key: 'reservable_id'

end
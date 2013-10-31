module Bookings
  class Appointment < ActiveRecord::Base
    
    belongs_to :reservable, class_name: Bookings.reservable_class_name
    belongs_to :customer, class_name: Bookings.customer_class_name

    require 'duration'
    include Duration

    validate :appointment_in_time_slot

    def appointment_in_time_slot
    	slots = reservable.time_slots.where("from_time <= :from_time AND to_time >= :to_time", {from_time: from_time, to_time: to_time})
    	errors.add(:from_time, "You tried to book an appointment where reservable is not available.") unless slots.exists?
    end

  end
end

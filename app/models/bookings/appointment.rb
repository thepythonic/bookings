module Bookings
  class Appointment < ActiveRecord::Base
    require 'duration'
        
    belongs_to :reservable, class_name: Bookings.reservable_class_name
    belongs_to :customer, class_name: Bookings.customer_class_name

    include Duration

    validate :appointment_in_time_slot
    validate :not_in_the_past

    def appointment_in_time_slot
    	slots = reservable.time_slots.where("from_time <= :from_time AND to_time >= :to_time", 
                                          {from_time: from_time, to_time: to_time})
    	errors.add(:from_time, 
                  "You tried to book an appointment where reservable is not available.") unless slots.exists?
    end

    def reschedule_by(current_user, params)
      old_appointment = self.dup  
      if updated = update(params)
        if self.customer.allow_notification?
          AppointmentNotifierMailer.appointment_reschedule(current_user, self, old_appointment).deliver 
        end
      end
      updated
    end

    def cancel(current_user)
      old_appointment = self.dup  
      self.delete
      if self.customer.allow_notification?
        AppointmentNotifierMailer.appointment_cancel(current_user, old_appointment).deliver 
      end
    end

  end
end

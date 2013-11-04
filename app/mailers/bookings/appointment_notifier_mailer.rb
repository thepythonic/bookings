module Bookings
  class AppointmentNotifierMailer < ActionMailer::Base
    default from: "from@example.com"

    def appointment_reschedule(user, appointment, old_appointment)
    	@user = user
    	@appointment = appointment
    	@old_appointment = old_appointment
    	to = if user.is_admin?
    		[appointment.reservable.email, appointment.customer.email]
    	elsif user.is_customer?
    		appointment.reservable.email
    	elsif user.is_reservable?
    		appointment.customer.email
    	end
    	mail(to: to, subject: "Appointment is Rescheduled")
    end
  end
end

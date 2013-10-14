@AppointmentList = Backbone.Collection.extend
  model: Appointment
  url: '/bookings/appointments.json'
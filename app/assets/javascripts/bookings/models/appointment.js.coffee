class @Appointment extends Backbone.Model
  
  urlRoot: ->
    '/bookings/appointments/'

  toJSON: ->
    data = _(@attributes).clone();
    data.from_formatted = @from_formatted()
    data

  from_formatted: ->
    moment(@get('from')).format('hh:mm a')
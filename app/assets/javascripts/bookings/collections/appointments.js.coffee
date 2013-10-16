class @AppointmentList extends Backbone.Collection
  model: Appointment

  initialize: (options) ->
    options || (options = {})
    @start = options.start
    @end = options.end

  url: ->
    x = ''
    x += '/start/' + @start if @start
    x += '/end/' + @end if @end
    x += '.json' 
    '/bookings/appointments' + x
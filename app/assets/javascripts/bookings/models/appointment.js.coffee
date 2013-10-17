class @Appointment extends Backbone.Model
  
  urlRoot: ->
    '/bookings/appointments/'

  initialize: (model) ->
    @model = model
    if @model.hasOwnProperty('appointments')
      _.each @model.appointments.models, (m) ->
        m.set('from_formatted', moment(m.get('from')).format('hh:mm a'))

  toJSON: ->
    data = _(@attributes).clone();
    data.from_formatted = @from_formatted()
    data

  from_formatted: ->
    moment(@get('from')).format('hh:mm a')
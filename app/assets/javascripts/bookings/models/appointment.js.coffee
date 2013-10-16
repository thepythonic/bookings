class @Appointment extends Backbone.Model
  
  urlRoot: ->
    '/bookings/appointments/'

  initialize: (model) ->
    @model = model
    if @model instanceof Array
      _.each @model, (m) ->
        m.from_formatted = moment(m.from).format('hh:mm a')

  toJSON: ->
    data = _(@attributes).clone();
    data.from_formatted = @from_formatted()
    data

  from_formatted: ->
    moment(@get('from')).format('hh:mm a')
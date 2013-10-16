class @CalendarDateList extends Backbone.Collection
  model: CalendarDate

  url: ->
    '/bookings/appointments/' 

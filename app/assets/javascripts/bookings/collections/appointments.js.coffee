class @AppointmentList extends Backbone.Collection
  model: Appointment

  initialize: (options) ->
    options || (options = {})
    @start = options.start
    @end = options.end
    @week = options.week

  url: ->
    x = ''
    x += '/start/' + @start if @start
    x += '/end/' + @end if @end
    x += '.json' 
    '/bookings/appointments' + x

  comparator: (item) ->
    item.get('from')

  parse: (response)->
    collection = []
    prev = {}
    for a, b of response
      diff = moment(prev).diff(moment(a))
      while diff < -86400000
        diff += 86400000
        collection.push
          date: moment(a)
          appointments: new AppointmentList

      b = _.map b, (a)->
       new Appointment a
       
      collection.push 
        date: moment(a)
        appointments: new AppointmentList b

      prev = a

    
    if @week
      console.log(collection.length)
      for i in [collection.length...7]
        collection.push
          date: moment(collection[collection.length-1].date).add('days', 1)
          appointments: new AppointmentList 
      
      collection
    else
      response 

class @AppointmentList extends Backbone.Collection
  model: Appointment

  initialize: (options) ->
    options || (options = {})
    @start = options.start
    @end = options.end
    @mode = options.mode

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
    prev = moment(@start, 'X')
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


    # console.log(@mode == 'week')
    
    if @mode == 'week'
      for i in [collection.length...7]
        collection.push
          date: moment(collection[collection.length-1].date).add('days', 1)
          appointments: new AppointmentList 
      
      collection
    
    else if @mode == 'month'
      for i in [collection.length...31]
        collection.push
          date: moment(collection[collection.length-1].date).add('days', 1)
          appointments: new AppointmentList 

      console.log(collection)
      collection

    else
      response 

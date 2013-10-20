@Bookings.module "Appointment", (Appointment, Bookings, Backbone, Marionette, $, _)->
  class Appointment.Appointment extends Backbone.Model
    
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

  class Appointment.AppointmentList extends Backbone.Collection
    model: Appointment.Appointment

    initialize: (options) ->
      options || (options = {})
      @start = options.start
      @end = options.end
      @mode = options.mode

    url: ->
      q = ''
      q += '/start/' + @start if @start
      q += '/end/' + @end if @end
      q += '.json' 
      "/bookings/appointments#{q}"

    comparator: (item) ->
      item.get('from')

    parse: (response)->
      #TODO HZ: What about getting the data from server??!
      collection = []
      prev = moment(@start, 'X') #convert unix time to date
      for a, b of response
        diff = moment(prev).diff(moment(a))
        #TODO HZ: check logic here, need more accurate calculation.
        while diff < -86400000 
          diff += 86400000
          collection.push
            date: moment(a)
            appointments: new Appointment.AppointmentList

        b = _.map b, (a)->
         new Appointment.Appointment a
         
        collection.push 
          date: moment(a)
          appointments: new Appointment.AppointmentList b

        prev = a
      
      if @mode == 'week'
        # add emtpy list at the end of the collection if the collection length is less than 7 (days)
        for i in [collection.length...7]
          if collection.length > 0
            date = collection[collection.length-1].date   
          else
            date = @start

          collection.push
            date: moment(date).add('days', 1)
            appointments: new Appointment.AppointmentList 
        
        collection
      
      else if @mode == 'month'
        for i in [collection.length...31]
          collection.push
            date: moment(collection[collection.length-1].date).add('days', 1)
            appointments: new Appointment.AppointmentList 

        collection

      else
        response 


  API = 
    getAppointmentsFor: (start, end, mode)->
      appointments = new Appointment.AppointmentList
        mode: mode
        start: start
        end: end

  Bookings.reqres.setHandler 'calendar:appointments:range', (start, end, mode)->
    API.getAppointmentsFor(start, end, mode)
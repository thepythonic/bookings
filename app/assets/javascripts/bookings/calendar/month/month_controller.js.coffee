@Bookings.module 'CalendarApp.Month', (Month, Bookings, Backbone, Marionette, $, _)->
  Month.Controller = 
    ShowMonth: (options) ->
      layout = new Bookings.CalendarApp.Views.Layout()
      header = new Bookings.CalendarApp.Month.HeaderView(model: new CalendarDate())

      Bookings.calendar.show(layout)
      layout.header.show(header)
      
      header.on 'calendar:month:nextPrev', (n) ->
        Bookings.vent.trigger('nextPrev:month', n)
        Bookings.navigate("calendar/month/" + n.month()+1 )

      layout.on 'calendar:appointments'

    showAppointments: (options)->
      calendarWeekLayout = new Month.Layout()
      Bookings.content.show(calendarMonthLayout)
      calendarMonthLayout.header.show(new Bookings.CalendarApp.Month.HeaderCollection(collection: collection))
      appointmentList = new AppointmentList
        mode: options.mode
        start: options.start.unix()
        end: options.end.unix()

      calendarMonthLayout.content.show(new Bookings.CalendarApp.Month.ContentCollection(collection: appointmentList))
      appointmentList.fetch()
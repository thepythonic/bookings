@Bookings.module 'CalendarApp.Week', (Week, Bookings, Backbone, Marionette, $, _)->
  Week.Controller = 
    ShowWeek: (options)->
      layout = new Bookings.CalendarApp.Views.Layout()
      header = new Week.HeaderView(model: new CalendarDate())

      Bookings.calendar.show(layout)
      layout.header.show(header)
      
      header.on 'calendar:week:nextPrev', (n) ->
        Bookings.vent.trigger('nextPrev:week', n)
        Bookings.navigate("calendar/week/" + n.week())
    
    showAppointments: (options)->
      calendarWeekLayout = new Week.Layout()
      Bookings.content.show(calendarWeekLayout)
      calendarWeekLayout.header.show(new Bookings.CalendarApp.Week.HeaderCollection(collection: collection))
      appointmentList = new AppointmentList
        mode: options.mode
        start: options.start.unix()
        end: options.end.unix()

      calendarWeekLayout.content.show(new Bookings.CalendarApp.Week.ContentCollection(collection: appointmentList))
      appointmentList.fetch()

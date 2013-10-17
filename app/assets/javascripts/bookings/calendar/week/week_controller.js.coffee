@Bookings.module 'CalendarApp.Week', (Week, Bookings, Backbone, Marionette, $, _)->
  Week.Controller = 
    ShowWeek: ->
      layout = new Bookings.CalendarApp.Views.Layout()
      header = new Bookings.CalendarApp.Week.HeaderView(model: new CalendarDate())

      Bookings.calendar.show(layout)
      layout.header.show(header)
      # layout.weekView()
      
      header.on 'calendar:week:nextPrev', (n) ->
        console.log('AAAA')
        Bookings.vent.trigger('nextPrev:week', n)

      
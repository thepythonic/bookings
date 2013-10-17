@Bookings.module "CalendarApp", (CalendarApp, Bookings, Backbone, Marionette, $, _)->
  
  class CalendarApp.Router extends Marionette.AppRouter
    appRoutes:
      "calendar": "showDayCalendar" 
      "calendar/day": "showDayCalendar" 
      "calendar/week": "showWeekCalendar" 
      "calendar/month": "showMonthCalendar" 

  API =
    showDayCalendar: ->
      console.log('Show Day Calendar')

    showWeekCalendar: ->
      CalendarApp.Week.Controller.ShowWeek()
      
    showMonthCalendar: ->
      CalendarApp.Month.Controller.ShowMonth()

  Bookings.on 'calendar:day', ->
    Bookings.navigate("calendar")
    API.showDayCalendar()

  Bookings.on 'calendar:week', ->
    Bookings.navigate("calendar/week")
    API.showWeekCalendar()
    
  Bookings.on 'calendar:month', ->
    Bookings.navigate("calendar/month")
    API.showMonthCalendar()

  CalendarApp.addInitializer ->
    new CalendarApp.Router
      controller: API

    Bookings.trigger('calendar:week')
  
@Bookings.module "CalendarApp", (CalendarApp, Bookings, Backbone, Marionette, $, _)->
  class CalendarApp.Router extends Marionette.AppRouter
    appRoutes:
      "calendar": "showDayCalendar" 
      "calendar/day": "showDayCalendar" 
      "calendar/week": "showWeekCalendar" 
      "calendar/month": "showMonthCalendar" 

  API:
    showDayCalendar: ->
      console.log('Show Day Calendar')
@Bookings.module "CalendarApp", (CalendarApp, Bookings, Backbone, Marionette, $, _)->
  
  class CalendarApp.Router extends Marionette.AppRouter
    appRoutes:
      "calendar/:year/day(/:n)": "showDayCalendar" 
      "calendar/:year/week(/:n)": "calendarView" 
      "calendar/:year/month(/:n)": "showMonthCalendar" 

  API =
    showDayCalendar: ->
      console.log('Show Day Calendar')

    calendarView: (year, n)->
      today = moment()
      year || (year = today.year())
      n || (n = today.week())
      Bookings.trigger 'calendar:week', year, n

    showWeekCalendar: (year, n)->
      date_s = year + " " + n
      date = moment(date_s, "YYYY ww")
      layout = new CalendarApp.Views.Layout()
      header = new CalendarApp.Views.CalendarHeader(model: new CalendarDate(date: date))

      Bookings.calendar.show(layout)
      layout.header.show(header)

      
    showMonthCalendar: (n)->
      CalendarApp.Month.Controller.ShowMonth(n)

    showWeekAppointments: (n)->
      CalendarApp.Views.Week.Controller.showAppointments(n)
    
    showMonthAppointments: (n)->
      CalendarApp.Views.Month.Controller.showAppointments(n)


  CalendarApp.addInitializer ->
    new CalendarApp.Router
      controller: API
  
  Bookings.on 'calendar:week', (year, n)->
    Bookings.navigate("calendar/" + year + "/week/" + n)
    API.showWeekCalendar(year, n)
    


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
      date_s = year + " " + n + ' 1'
      d = moment().year(year).week(n)
      week_start = d.startOf('week').unix()
      week_end = d.endOf('week').unix()
      days_range = moment(d.startOf('week')).twix(d.endOf('week'), true).iterate('days')
      
      collection = Bookings.request('calendar:datelist:range', days_range)

      appointmentList = Bookings.request('calendar:appointments:range', week_start, week_end, "week")
      
      layout = new CalendarApp.Views.Layout()
      header = new CalendarApp.Views.CalendarHeader(model: new CalendarApp.Models.CalendarDate(date: d))
      
      #calendar layout regions
      calendarheader = new CalendarApp.Views.HeaderCollection(collection: collection)
      calendarContent = new CalendarApp.Views.ContentCollection(collection: appointmentList)
      #calendar layout
      calendarLayout = new CalendarApp.Views.CalendarLayout()

      Bookings.calendar.show(layout)
      layout.header.show(header)
      layout.content.show(calendarLayout)

      calendarLayout.header.show(calendarheader)
      calendarLayout.content.show(calendarContent)
      linksRow = new CalendarApp.Views.AddLinkCollection(collection: collection)
      calendarLayout.content.$el.append(linksRow.render().$el)
      appointmentList.fetch()

      
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
    


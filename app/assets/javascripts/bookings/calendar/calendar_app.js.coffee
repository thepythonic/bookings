@Bookings.module "CalendarApp", (CalendarApp, Bookings, Backbone, Marionette, $, _)->
  
  class CalendarApp.Router extends Marionette.AppRouter
    appRoutes:
      "calendar/:year/day(/:n)": "showDayCalendar" 
      "calendar/:year/week(/:n)": "calendarWeekView" 
      "calendar/:year/month(/:n)": "calendarMonthView" 

  API =
    showDayCalendar: ->
      console.log('Show Day Calendar')

    calendarMonthView: (year, n)->
      today = moment()
      year || (year = today.year())
      n || (n = today.month())
      Bookings.trigger 'calendar:month', year, n

    calendarWeekView: (year, n)->
      today = moment()
      year || (year = today.year())
      n || (n = today.week())
      Bookings.trigger 'calendar:week', year, n

    showWeekCalendar: (year, n)->
      date_s = year + " " + n + ' 1'
      d = moment().year(year).week(n)
      start = d.startOf('week').unix()
      end = d.endOf('week').unix()
      days_range = moment(d.startOf('week')).twix(d.endOf('week'), true).iterate('days')
      
      collection = Bookings.request('calendar:datelist:range', days_range)

      appointmentList = Bookings.request('calendar:appointments:range', start, end, "week")
      
      layout = new CalendarApp.Views.Week.Layout()
      header = new CalendarApp.Views.Week.CalendarHeader(model: new CalendarApp.Models.CalendarDate(date: d))
      switcher = new CalendarApp.Views.Swicther()

      #calendar layout regions
      calendarheader = new CalendarApp.Views.Week.HeaderCollection(collection: collection)
      calendarContent = new CalendarApp.Views.Week.ContentCollection(collection: appointmentList)
      calendarLayout = new CalendarApp.Views.Week.CalendarLayout()

      Bookings.calendar.show(layout)
      layout.header.show(header)
      layout.content.show(calendarLayout)
      layout.switcher.show(switcher)
      switcher.resetButtons($('.button-group .week-view'))

      calendarLayout.header.show(calendarheader)
      calendarLayout.content.show(calendarContent)
      
      linksRow = new CalendarApp.Views.Week.AddLinkCollection(collection: collection)
      calendarLayout.content.$el.append(linksRow.render().$el)
      
      appointmentList.fetch()

      
    showMonthCalendar: (year, n)->
      date_s = year + " " + n + ' 1'
      d = moment().year(year).month(n) 
      d_start = moment().year(year).month(n) 
      d_end = moment().year(year).month(n)
      start = d_start.startOf('month').unix()
      end = d_end.endOf('month').unix()
      month_start = d_start.startOf('month').startOf('week')
      month_end = d_end.endOf('month').endOf('week')
      days_range = moment(month_start).twix(month_end, true).iterate('days')

      collection = Bookings.request('calendar:datelist:month:range', days_range)
      
      layout = new CalendarApp.Views.Month.Layout()
      header = new CalendarApp.Views.Month.CalendarHeader(model: new CalendarApp.Models.CalendarDate(date: d, mode: 'month'))
      switcher = new CalendarApp.Views.Swicther()
      calendar = new CalendarApp.Views.Month.Calendar(collection: collection)
      
      Bookings.calendar.show(layout)
      layout.header.show(header)
      layout.content.show(calendar)
      layout.switcher.show(switcher)
      switcher.resetButtons($('.button-group .month-view'))
      
     

  CalendarApp.addInitializer ->
    new CalendarApp.Router
      controller: API
  
  Bookings.on 'calendar:week', (year, n)->
    Bookings.navigate("calendar/" + year + "/week/" + n)
    API.showWeekCalendar(year, n)

  Bookings.on 'calendar:month', (year, n)->
    Bookings.navigate("calendar/" + year + "/month/" + n)
    API.showMonthCalendar(year, n)
    


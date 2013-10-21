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
      d = (moment().year year).week(n)
      start = (d.startOf 'week').unix()
      end = (d.endOf 'week').unix()
      days_range = (moment d.startOf 'week' ).twix(d.endOf 'week' , true).iterate('days')
      
      collection = Bookings.request 'calendar:datelist:range', days_range

      appointmentList = Bookings.request 'calendar:appointments:range', start, end, "week"
      
      layout = new CalendarApp.Views.Week.Layout()
      header = new CalendarApp.Views.Week.CalendarHeader model: new CalendarApp.Models.CalendarDate date: d
      switcher = new CalendarApp.Views.Swicther()

      #calendar layout regions
      calendarheader = new CalendarApp.Views.Week.HeaderCollection collection: collection
      calendarContent = new CalendarApp.Views.Week.ContentCollection collection: appointmentList
      calendarContentLayout = new CalendarApp.Views.Week.CalendarContentLayout()

      Bookings.calendar.show layout
      layout.header.show header
      layout.content.show calendarContentLayout
      layout.switcher.show switcher
      switcher.resetButtons $ '.button-group .week-view'

      calendarContentLayout.header.show calendarheader
      calendarContentLayout.content.show calendarContent
            
      appointmentList.fetch()

      
    showMonthCalendar: (year, n)->
      d = (moment().year year).month n  
      d_start = d.clone()
      d_end = d.clone()
      start = (d_start.startOf 'month').unix()
      end = (d_end.endOf 'month').unix()
      month_start = (d_start.startOf 'month').startOf 'week' 
      month_end = (d_end.endOf 'month').endOf 'week' 
      days_range = (moment month_start).twix(month_end, true).iterate 'days'

      collection = Bookings.request 'calendar:datelist:month:range', days_range, n
      
      layout = new CalendarApp.Views.Month.Layout()
      header = new CalendarApp.Views.Month.CalendarHeader model: new CalendarApp.Models.CalendarDate date: d, mode: 'month'
      switcher = new CalendarApp.Views.Swicther()
      calendar = new CalendarApp.Views.Month.Calendar collection: collection
      
      Bookings.calendar.show layout
      layout.header.show header 
      layout.content.show calendar 
      layout.switcher.show switcher
      switcher.resetButtons $ '.button-group .month-view'
      
     

  CalendarApp.addInitializer ->
    new CalendarApp.Router
      controller: API
  
  Bookings.on 'calendar:week', (year, n)->
    Bookings.navigate "calendar/" + year + "/week/" + n
    API.showWeekCalendar parseInt(year), parseInt(n)

  Bookings.on 'calendar:month', (year, n)->
    Bookings.navigate "calendar/" + year + "/month/" + n
    API.showMonthCalendar parseInt(year), parseInt(n)
    


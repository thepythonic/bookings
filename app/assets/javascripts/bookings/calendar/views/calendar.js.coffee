@Bookings.module "CalendarApp.Views", (Views, Bookings, Backbone, Marionette, $, _)->
  
  class Views.Layout extends Marionette.Layout
    template: '#calendar-layout'

    regions:
      'header': '#calendar-header'
      'content': '#calendar-content'

    initialize: ->
      Bookings.vent.on 'nextPrev:day', @nextPrevDay, 'day'
      Bookings.vent.on 'nextPrev:week', @nextPrevWeek, 'day'
      Bookings.vent.on 'nextPrev:month', @nextPrevMonth, 'day'

    events:
      'click .day-view': 'dayView'
      'click .week-view': 'weekView'
      'click .month-view': 'monthView'

    nextPrevDay: (day) ->
      console.log(day)
    
    nextPrevWeek: (day) =>
      week_start = moment(day).startOf('week')
      week_end = moment(day).endOf('week')
      @calendarDaysRange(week_start, week_end, 'week')

    nextPrevMonth: (day) ->
      month_start = moment(day).startOf('month')
      month_end = moment(day).endOf('month')
      @calendarDaysRange(month_start, month_end, "month")

    dayView: (e) ->
      Bookings.trigger('calendar:day')
      # e.preventDefault()
      # @resetButtons($(e.target))
      # @header.show(new CalendarDayHeaderView(model: new CalendarDate()))
      # appointments =  new AppointmentList()
      # @content.show(new CalendarDayView(collection: appointments))
      # appointments.fetch()

    weekView: (e) ->
      e.preventDefault()
      @resetButtons($('.week-view'))
      week_start = moment().startOf('week')
      week_end = moment().endOf('week')
      @calendarDaysRange(week_start, week_end, "week")
      

    monthView: (e) ->
      e.preventDefault()
      @resetButtons($(e.target))
      month_start = moment().startOf('month')
      month_end = moment().endOf('month')
      @calendarDaysRange(month_start, month_end, 'month')

    resetButtons: (target) ->
      $('.button-bar .active').removeClass('active')
      target.addClass('active')

    calendarDaysRange: (start, end, mode) ->
      days_range = moment(start).twix(end, true).iterate('days')
      collection = []
      while days_range.hasNext()
        collection.push(new CalendarDate(date: days_range.next()))

      options = 
        mode: mode
        start: start.unix()
        end: end.unix()

      @trigger('calendar:show:appointments', options)

      collection = new CalendarDateList(collection)
      appointmentList = new AppointmentList options
        
      if mode == 'week'
        calendarLayout = new Bookings.CalendarApp.Week.Layout()
        headerCollection = new Bookings.CalendarApp.Week.HeaderCollection(collection: collection)
        contectCollection = new Bookings.CalendarApp.Week.ContentCollection(collection: appointmentList)
      else if mode == 'month'
        calendarLayout = new Bookings.CalendarApp.Month.Layout()
        headerCollection = new Bookings.CalendarApp.Month.HeaderCollection(collection: collection)
        contectCollection = new Bookings.CalendarApp.Month.ContentCollection(collection: appointmentList)
      
      @content.show(calendarLayout)
      calendarLayout.header.show(headerCollection)
      calendarLayout.content.show(contectCollection)
      appointmentList.fetch()


class @CalendarDayHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-day-header'

  events:
    'click .next': 'nextDay'
    'click .prev': 'prevDay'

  nextDay: (e) ->
    n = moment(@model.get('date')).add('days', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()
    Bookings.vent.trigger('nextPrev:day', n)

  prevDay: (e) ->
    n = moment(@model.get('date')).subtract('days', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()
    Bookings.vent.trigger('nextPrev:day', n)

#DAY
class @CalendarDayItemView extends Backbone.Marionette.ItemView
  template: '#day-itemview'

class @CalendarDayView extends Backbone.Marionette.CollectionView
  itemView: CalendarDayItemView
  tagName: 'tr'
 

#MONTH
class @CalendarMonthItemView extends Backbone.Marionette.ItemView
  template: '#month-itemview'

class @CalendarMonthView extends Backbone.Marionette.CollectionView
  itemView: CalendarMonthItemView
  tagName: 'tr'


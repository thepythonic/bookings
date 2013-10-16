@Bookings.module "CalendarApp.Views", (Views, Bookings, Backbone, Marionette, $, _)->
  
  class Views.Layout extends Marionette.Layout
    template: '#calendar-layout'

    regions:
      'header': '#calendar-header'
      'content': '#calendar-content'

    initialize: ->
      Bookings.vent.on 'nextPrev:day', @nextDay, 'day'
      Bookings.vent.on 'nextPrev:week', @nextPrevWeek, 'day'
      Bookings.vent.on 'nextPrev:month', @nextPrevMonth, 'day'

    events:
      'click .day-view': 'dayView'
      'click .week-view': 'weekView'
      'click .month-view': 'monthView'
      'next:Day': 'nextDay'

    nextPrevDay: (day) ->
      console.log(day)
    
    nextPrevWeek: (day) =>
      week_start = moment(day).startOf('week')
      week_end = moment(day).endOf('week')
      @calendarWeekRange(week_start, week_end)

    nextPrevMonth: (day) ->
      console.log(day)

    dayView: (e) ->
      @resetButtons($(e.target))
      @header.show(new CalendarDayHeaderView(model: new CalendarDate()))
      appointments =  new AppointmentList()
      @content.show(new CalendarDayView(collection: appointments))
      appointments.fetch()

    weekView: (e) ->
      @resetButtons($(e.target))
      @header.show(new Bookings.CalendarApp.Week.HeaderView(model: new CalendarDate()))
      week_start = moment().startOf('week')
      week_end = moment().endOf('week')
      @calendarWeekRange(week_start, week_end)
      

    monthView: (e) ->
      @resetButtons($(e.target))
      @header.show(new CalendarMonthHeaderView(model: new CalendarDate()))
      @content.show(new CalendarMonthView())

    resetButtons: (target) ->
      $('.button-bar .active').removeClass('active')
      target.addClass('active')

    calendarWeekRange: (week_start, week_end) ->
      days_range = moment(week_start).twix(week_end, true).iterate('days')
      collection = []
   
      while days_range.hasNext()
        collection.push(new CalendarDate(date: days_range.next()))

      collection = new CalendarDateList(collection)
      calendarWeekLayout = new Bookings.CalendarApp.Week.Layout()
      @content.show(calendarWeekLayout)
      calendarWeekLayout.header.show(new Bookings.CalendarApp.Week.HeaderCollection(collection: collection))
      appointmentList = new AppointmentList
        week: true
        start: week_start.unix()
        end: week_end.unix()

      calendarWeekLayout.content.show(new Bookings.CalendarApp.Week.ContentCollection(collection: appointmentList))
      appointmentList.fetch()


class @CalendarDayHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-day-header'

  events:
    'click .next': 'nextDay'
    'click .prev': 'prevDay'

  nextDay: ->
    n = moment(@model.get('date')).add('days', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()
    Bookings.vent.trigger('nextPrev:day', n)

  prevDay: ->
    n = moment(@model.get('date')).subtract('days', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()
    Bookings.vent.trigger('nextPrev:day', n)

class @CalendarMonthHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-month-header'
  
  events:
    'click .next': 'nextMonth'
    'click .prev': 'prevMonth'

  nextMonth: ->
    n = moment(@model.get('date')).startOf('month').add('months', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()

  prevMonth: ->
    n = moment(@model.get('date')).startOf('month').subtract('months', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()


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


class @CalendarLayout extends Backbone.Marionette.Layout
  template: '#calendar-layout'

  regions:
    'header': '#calendar-header'
    'content': '#calendar-content'

  initialize: ->
    Calendar.vent.on 'nextPrev:day', @nextDay, 'day'
    Calendar.vent.on 'nextPrev:week', @nextPrevWeek, 'day'
    Calendar.vent.on 'nextPrev:month', @nextMonth, 'day'

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
    @header.show(new CalendarWeekHeaderView(model: new CalendarDate()))
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

    collection= new CalendarDateList(collection)
    calendarWeekLayout = new CalendarWeekLayout(collection)
    @content.show(calendarWeekLayout)
    


class @CalendarWeekLayout extends Backbone.Marionette.Layout
  template: '#week-view'
  regions:
    header: '#week-header'
    content: '#week-content'
  
  initialize: (collection)->
    console.log(collection)
    c = new CalendarWeekCollection(collection: collection)
    c.render()
    console.log(c.$l)
    @header.show(c)


class @CalendarDayHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-day-header'

  events:
    'click .next': 'nextDay'
    'click .prev': 'prevDay'

  nextDay: ->
    n = moment(@model.get('date')).add('days', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()
    Calendar.vent.trigger('nextPrev:day', n)

  prevDay: ->
    n = moment(@model.get('date')).subtract('days', 1)
    @model.set('date', n.format('MMM D, YYYY'))
    @render()
    Calendar.vent.trigger('nextPrev:day', n)

class @CalendarWeekHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-week-header'

  events:
    'click .next': 'nextWeek'
    'click .prev': 'prevWeek'

  nextWeek: ->
    n = moment(@model.get('date')).startOf('week').add('weeks', 1)
    @model.set('date', n)
    @render()
    Calendar.vent.trigger('nextPrev:week', n)

  prevWeek: ->
    n = moment(@model.get('date')).startOf('week').subtract('weeks', 1)
    @model.set('date')
    @render()
    Calendar.vent.trigger('nextPrev:week', n)

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



class @CalendarDayItemView extends Backbone.Marionette.ItemView
  template: '#day-itemview'

class @CalendarDayView extends Backbone.Marionette.CollectionView
  itemView: CalendarDayItemView
  tagName: 'tr'
  

class @CalendarWeekItemView extends Backbone.Marionette.ItemView
  template: '#week-itemview'
  tagName: 'th'

class @CalendarWeekCollection extends Backbone.Marionette.CollectionView
  itemView: CalendarWeekItemView
  tagName: 'tr'


class @CalendarMonthItemView extends Backbone.Marionette.ItemView
  template: '#month-itemview'

class @CalendarMonthView extends Backbone.Marionette.CollectionView
  itemView: CalendarMonthItemView
  tagName: 'tr'


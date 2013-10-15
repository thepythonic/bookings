class @CalendarLayout extends Backbone.Marionette.Layout
  template: '#calendar-layout'

  regions:
    'header': '#calendar-header'
    'content': '#calendar-content'


  events:
    'click .day-view': 'dayView'
    'click .week-view': 'weekView'
    'click .month-view': 'monthView'

  dayView: (e) ->
    @resetButtons($(e.target))
    @header.show(new CalendarDayHeaderView(model: new CalendarDate()))

  weekView: (e) ->
    @resetButtons($(e.target))
    @header.show(new CalendarWeekHeaderView(model: new CalendarDate()))
  
  monthView: (e) ->
    @resetButtons($(e.target))
    @header.show(new CalendarMonthHeaderView(model: new CalendarDate()))

  resetButtons: (target) ->
    $('.button-bar .active').removeClass('active')
    target.addClass('active')

class @CalendarDayHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-day-header'

  events:
    'click .next': 'nextDay'
    'click .prev': 'prevDay'

  nextDay: ->
    n = moment(@model.get('date')).add('days', 1).format('MMM D, YYYY')
    @model.set('date', n)
    @render()

  prevDay: ->
    n = moment(@model.get('date')).subtract('days', 1).format('MMM D, YYYY')
    @model.set('date', n)
    @render()



class @CalendarWeekHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-week-header'

  events:
    'click .next': 'nextWeek'
    'click .prev': 'prevWeek'

  nextWeek: ->
    n = moment(@model.get('date')).startOf('week').add('weeks', 1).format('MMM D, YYYY')
    @model.set('date', n)
    @render()

  prevWeek: ->
    n = moment(@model.get('date')).startOf('week').subtract('weeks', 1).format('MMM D, YYYY')
    @model.set('date', n)
    @render()


class @CalendarMonthHeaderView extends Backbone.Marionette.ItemView
  template: '#calendar-month-header'
  
  events:
    'click .next': 'nextMonth'
    'click .prev': 'prevMonth'

  nextMonth: ->
    n = moment(@model.get('date')).startOf('month').add('months', 1).format('MMM D, YYYY')
    @model.set('date', n)
    @render()

  prevMonth: ->
    n = moment(@model.get('date')).startOf('month').subtract('months', 1).format('MMM D, YYYY')
    @model.set('date', n)
    @render()


class @CalendarWeekView extends Backbone.Marionette.CompositeView
    


class @CalendarMonthView extends Backbone.Marionette.CompositeView
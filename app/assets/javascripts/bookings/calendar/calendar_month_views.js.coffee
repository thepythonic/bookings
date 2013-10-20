@Bookings.module "CalendarApp.Views.Month", (Month, Bookings, Backbone, Marionette, $, _)->
  
  class Month.Layout extends Bookings.CalendarApp.Views.Layout
    

  class Month.CalendarHeader extends Bookings.CalendarApp.Views.CalendarHeader
    
    events:
      'click .next': 'nextMonth'
      'click .prev': 'prevMonth'

    updateHeader: (n)->
      @model.set 'date', n
      Bookings.trigger 'calendar:month', n.year(), n.month()
      @render() 

    nextMonth: (e) ->
      e.preventDefault()
      n = (moment @model.get 'date').add 'months', 1
      @updateHeader n

    prevMonth: (e) ->
      e.preventDefault()
      n = (moment @model.get 'date' ).subtract 'months', 1
      @updateHeader n

  class Month.ContentItem extends Marionette.ItemView
    template: '#content-month-itemview'
    tagName: 'tr'

    events:
      "click .add-appointment": 'addAppointmentView'

    addAppointmentView: ->
      (@model.get 'appointments').add new Appointment from: @model.get 'date'
      @render()

  class Month.Calendar extends Marionette.CompositeView
    itemView: Month.ContentItem
    template: '#calendar-month-layout'
    className: 'row'
    itemViewContainer: 'tbody'

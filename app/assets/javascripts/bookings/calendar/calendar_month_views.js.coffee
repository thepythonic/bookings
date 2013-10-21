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
    tagName: 'td'

    initialize: ->
      @model.toJSON()

    events:
      'click .span-link': 'logMe'

    logMe: ->
      console.log(@model)

  class Month.ContentItems extends Marionette.CollectionView
    itemView: Month.ContentItem
    tagName: 'tr'

    initialize: (options)->
      @collection =  new Bookings.CalendarApp.Models.CalendarDateList(options.model.get('models'))

  class Month.Calendar extends Marionette.CompositeView
    itemView: Month.ContentItems
    template: '#calendar-month-layout'
    itemViewContainer: 'tbody'

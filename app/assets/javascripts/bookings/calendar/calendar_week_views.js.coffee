@Bookings.module "CalendarApp.Views.Week", (Week, Bookings, Backbone, Marionette, $, _)->
  
  class Week.Layout extends Bookings.CalendarApp.Views.Layout


  class Week.CalendarHeader extends Bookings.CalendarApp.Views.CalendarHeader
    events:
      'click .next': 'nextWeek'
      'click .prev': 'prevWeek'

    updateHeader: (n)->
      @model.set 'date', n
      Bookings.trigger 'calendar:week', n.year(), n.week()
      @render() 

    nextWeek: (e) ->
      e.preventDefault()
      n = (moment @model.get 'date').add 'weeks', 1
      @updateHeader n

    prevWeek: (e) ->
      e.preventDefault()
      n = (moment @model.get 'date').subtract 'weeks', 1
      @updateHeader n

  class Week.CalendarContentLayout extends Marionette.Layout
    template: '#calendar-layout'
    className: 'row'

    regions:
      header: '#calendar-table-header'
      content: '#calendar-table-content' 

  class Week.HeaderItem extends Marionette.ItemView
    template: '#header-itemview'
    tagName: 'th'

  class Week.HeaderCollection extends Marionette.CollectionView
    itemView: Week.HeaderItem
    tagName: 'tr'

  class Week.ContentItem extends Marionette.ItemView
    template: '#content-itemview'
    tagName: 'td'

  class Week.ContentCollection extends Backbone.Marionette.CollectionView
    itemView: Week.ContentItem
    tagName: 'tr'

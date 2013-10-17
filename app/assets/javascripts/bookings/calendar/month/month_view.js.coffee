@Bookings.module 'CalendarApp.Month', (Month, Bookings, Backbone, Marionette, $, _)->
  class Month.Layout extends Marionette.Layout
    template: '#month-view-layout'
    className: 'row'
    
    regions:
      header: '#month-header'
      content: '#month-content' 

  class Month.HeaderView extends Marionette.ItemView
    template: '#calendar-month-header'

    events:
      'click .next': 'nextMonth'
      'click .prev': 'prevMonth'

    nextMonth: (e) ->
      e.preventDefault()
      n = moment(@model.get('date')).startOf('month').add('months', 1)
      @model.set('date', n)
      @trigger('calendar:month:nextPrev', n)
      @render()

    prevMonth: (e) ->
      e.preventDefault()
      n = moment(@model.get('date')).startOf('month').subtract('months', 1)
      @model.set('date', n)
      @trigger('calendar:month:nextPrev', n)
      @render()

  class Month.HeaderItemView extends Marionette.ItemView
    template: '#month-header-itemview'
    tagName: 'th'

  class Month.HeaderCollection extends Marionette.CollectionView
    itemView: Month.HeaderItemView
    tagName: 'tr'

  class Month.ContentItemView extends Marionette.ItemView
    template: '#month-content-itemview'
    tagName: 'td'

  class Month.ContentCollection extends Backbone.Marionette.CollectionView
    itemView: Month.ContentItemView
    tagName: 'tr'
    

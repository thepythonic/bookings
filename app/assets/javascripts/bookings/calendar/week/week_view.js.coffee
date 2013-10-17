@Bookings.module 'CalendarApp.Week', (Week, Bookings, Backbone, Marionette, $, _)->
  class Week.Layout extends Marionette.Layout
    template: '#week-view-layout'
    className: 'row'

    regions:
      header: '#week-header'
      content: '#week-content' 

  class Week.HeaderView extends Marionette.ItemView
    template: '#calendar-week-header'

    events:
      'click .next': 'nextWeek'
      'click .prev': 'prevWeek'

    nextWeek: (e) ->
      e.preventDefault()
      n = moment(@model.get('date')).startOf('week').add('weeks', 1)
      @model.set('date', n)
      console.log 
      @trigger('calendar:week:nextPrev', n)
      @render()
      

    prevWeek: (e) ->
      e.preventDefault()
      n = moment(@model.get('date')).startOf('week').subtract('weeks', 1)
      @model.set('date', n)
      @render()
      Bookings.vent.trigger('nextPrev:week', n)

  class Week.HeaderItemView extends Marionette.ItemView
    template: '#week-header-itemview'
    tagName: 'th'

  class Week.HeaderCollection extends Marionette.CollectionView
    itemView: Week.HeaderItemView
    tagName: 'tr'

  class Week.ContentItemView extends Marionette.ItemView
    template: '#week-content-itemview'
    tagName: 'td'

    events:
      "click .add-appointment": 'addAppointmentView'

    addAppointmentView: ->
      @model.get('appointments').add(new Appointment({from: @model.get('date')}))
      @render()

  class Week.ContentCollection extends Backbone.Marionette.CollectionView
    itemView: Week.ContentItemView
    tagName: 'tr'
    
@Bookings.module "CalendarApp.Views", (Views, Bookings, Backbone, Marionette, $, _)->
  
  class Views.Layout extends Marionette.Layout
    template: '#module-layout'

    regions:
      'header': '#module-header'
      'content': '#module-content'

  class Views.CalendarHeader extends Marionette.ItemView
    template: '#calendar-header'

    events:
      'click .next': 'nextWeek'
      'click .prev': 'prevWeek'

    updateHeader: (n)->
      @model.set('date', n)
      Bookings.trigger('calendar:week', n.year(), n.week())
      @render() 

    nextWeek: (e) ->
      e.preventDefault()
      console.log(moment(@model.get('date')).toString())
      n = moment(@model.get('date')).add('weeks', 1)
      console.log(n.year())
      console.log(n.toString())
      @updateHeader n

    prevWeek: (e) ->
      e.preventDefault()
      n = moment(@model.get('date')).subtract('weeks', 1)
      @updateHeader n

  class Views.CalendarLayout extends Marionette.Layout
    template: '#calendar-layout'
    className: 'row'

    regions:
      header: '#calendar-table-header'
      content: '#calendar-table-content' 

  class Views.HeaderItem extends Marionette.ItemView
    template: '#header-itemview'
    tagName: 'th'

  class Views.HeaderCollection extends Marionette.CollectionView
    itemView: Views.HeaderItem
    tagName: 'tr'

  class Views.ContentItem extends Marionette.ItemView
    template: '#content-itemview'
    tagName: 'td'

    events:
      "click .add-appointment": 'addAppointmentView'

    addAppointmentView: ->
      @model.get('appointments').add(new Appointment({from: @model.get('date')}))
      @render()

  class Views.ContentCollection extends Backbone.Marionette.CollectionView
    itemView: Views.ContentItem
    tagName: 'tr'
@Bookings.module "CalendarApp.Views.Week", (Week, Bookings, Backbone, Marionette, $, _)->
  
  class Week.Layout extends Marionette.Layout
    template: '#module-layout'

    regions:
      switcher: '#calendar-switcher'
      header: '#module-header'
      content: '#module-content'

  class Week.CalendarHeader extends Marionette.ItemView
    template: '#calendar-header'

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

  class Week.CalendarLayout extends Marionette.Layout
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

    events:
      "click .add-appointment": 'addAppointmentView'

    addAppointmentView: ->
      (@model.get 'appointments').add new Appointment from: @model.get 'date'
      @render()

  class Week.ContentCollection extends Backbone.Marionette.CollectionView
    itemView: Week.ContentItem
    tagName: 'tr'

  class Week.AddLinkItem extends Marionette.ItemView
    template: '#add-link'
    tagName: 'td'

    events:
      'click .span-link': 'editView'

    editView: (e)->
      console.log(@model)

  class Week.AddLinkCollection extends Marionette.CollectionView
    itemView: Week.AddLinkItem
    tagName: 'tr'
    className: 'add-links'
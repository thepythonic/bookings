@Bookings.module "CalendarApp.Views", (Views, Bookings, Backbone, Marionette, $, _)->
  
  class Views.Layout extends Marionette.Layout
    template: '#module-layout'

    regions:
      switcher: '#calendar-switcher'
      header: '#module-header'
      content: '#module-content'

  class Views.CalendarHeader extends Marionette.ItemView
    template: '#calendar-header'

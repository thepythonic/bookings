Bookings.module "CalendarApp.Views", (Views, Bookings, Backbone, Marionette, $, _)->

  class Views.Swicther extends Marionette.ItemView
    template: '#calendar-view-switch'

    events:
      'click .week-view': 'weekView'
      'click .month-view': 'monthView'

    weekView: (e) ->
      e.preventDefault() if e
      @resetButtons $ '.week-view'
      today = moment()
      year || (year = today.year())
      n || (n = today.week())
      Bookings.trigger 'calendar:week', year, n

    monthView: (e) ->
      e.preventDefault() if e
      @resetButtons $ '.month-view'
      today = moment()
      year || (year = today.year())
      n || (n = today.month())
      Bookings.trigger 'calendar:month', year, n

    resetButtons: (target) ->
      ($ '.button-group .active').removeClass 'active'
      target.addClass 'active'
 
@AppointmentItemView = Backbone.Marionette.ItemView.extend
  model: Appointment
  template : '#appointment-item-view'
  tagName: 'li'
  className: ''


@AppointmentDayView = Backbone.Marionette.CompositeView.extend
  itemView: AppointmentItemView
  template: '#appointment-day'
  tagName: 'ul'
  className: 'row'
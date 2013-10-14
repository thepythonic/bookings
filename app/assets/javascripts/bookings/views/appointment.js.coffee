@AppointmentItemView = Backbone.Marionette.ItemView.extend
  template : '#appointment-itemview'
  tagName: 'li'
  className: ''

  events:
    'click': 'reschedule'
    
  reschedule: (event) ->
    editView = new AppointmentEditView model: @model
    $('#form').html(editView.render().$el)
    $('#form').foundation('reveal', 'open')
    $('.fdatetimepicker').fdatetimepicker
        format: 'mm-dd-yyyy hh:ii'


@AppointmentDayView = Backbone.Marionette.CompositeView.extend
  itemView: AppointmentItemView
  itemViewOptions:
    employees: @employees
    customers: @customers

  template: '#appointment-day'
  tagName: 'ul'
  className: 'row'

@AppointmentWeekView = Backbone.Marionette.CompositeView.extend
  

  
@AppointmentMonthView = Backbone.Marionette.CompositeView.extend
  

@AppointmentEditView = Backbone.Marionette.ItemView.extend
  template: '#appointment-edit'
  tagName: 'form'
  className: 'small-12 columns'

  events:
    'click .submit': 'submit'
    'click .close': 'close'

  close: ->
    @remove()

  submit: ->


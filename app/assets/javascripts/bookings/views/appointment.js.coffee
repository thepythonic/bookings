class @AppointmentItemView extends Backbone.Marionette.ItemView
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


class @AppointmentDayView extends Backbone.Marionette.CompositeView
  itemView: AppointmentItemView
  itemViewOptions:
    employees: @employees
    customers: @customers

  template: '#appointment-day'
  tagName: 'ul'
  className: 'row'

# class @AppointmentWeekView extends Backbone.Marionette.CompositeView
  


# class @AppointmentMonthView extends Backbone.Marionette.CompositeView
  

class @AppointmentEditView extends Backbone.Marionette.ItemView
  template: '#appointment-edit'
  tagName: 'form'
  className: 'small-12 columns'

  events:
    'click .submit': 'submit'
    'click .close': 'close'

  close: ->
    @remove()

  submit: ->


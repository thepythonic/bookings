@AppointmentItemView = Backbone.Marionette.ItemView.extend
  template : '#appointment-itemview'
  tagName: 'li'
  className: ''

  events:
    'click': 'reschedule'
    'click a.cancel': 'cancel'
    'click a.confirm': 'confirm'



  reschedule: (event) ->
    editView = new AppointmentEditView model: @model
    $('#form').html(editView.render().$el)

    
  cancel: ->
    console.log("cancel " + @model.get('id'))

  confirm: ->
    console.log("confirm " + @model.get('id'))


@AppointmentDayView = Backbone.Marionette.CompositeView.extend
  itemView: AppointmentItemView
  template: '#appointment-day'
  tagName: 'ul'
  className: 'row'

@AppointmentEditView = Backbone.Marionette.ItemView.extend
  template: '#appointment-edit'
  tagName: 'form'
  className: 'small-8 small-centered columns'

  events:
    'click .submit'
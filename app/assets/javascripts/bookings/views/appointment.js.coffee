@AppointmentItemView = Backbone.Marionette.ItemView.extend
  template : '#appointment-itemview'
  tagName: 'li'
  className: ''

  events:
    'click': 'reschedule'
    



  reschedule: (event) ->
    editView = new AppointmentEditView model: @model
    console.log ('ZZZZZZZZZ')
    $('#form').html(editView.render().$el)
    $('#form').foundation('reveal', 'open')

    
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
    'click .submit': ''
    'click .close': 'close'

  close: ->
    @remove()
    # $('#form').foundation('reveal', 'close')

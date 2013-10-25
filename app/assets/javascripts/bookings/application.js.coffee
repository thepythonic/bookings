
#= require ./jquery/jquery
#= require ./jquery-ui/ui/jquery-ui
#= require ./full_calendar/fullcalendar

Date.prototype.getMonthName = ->
  m = ['January','February','March','April','May','June','July', 'August','September','October','November','December']
  m[@getMonth()]

Date.prototype.getDayName = ->
  d = ['Sunday','Monday','Tuesday','Wednesday', 'Thursday','Friday','Saturday']
  d[@getDay()]

@FormHandler =
  setEvent: (event, data)->
    event.start.setHours(data.from_time.split(':')[0])
    event.start.setMinutes(data.from_time.split(':')[1])
    event.end.setHours(data.to_time.split(':')[0])
    event.end.setMinutes(data.to_time.split(':')[1])
    event.recurring = data.recurring if data.recurring
    event.id = data.id if data.id
    event

  displayErros: (errors)->
    $('#template_form .error').remove()
    ul = "<ul class='error'>"
    for key, value of errors
      ul += "<li>#{key}"
      li = "<ul>" + ["<li>#{v}</li>" for v in value].join() + "</ul>"
      ul += li + "</li>"
    ul += "</ul>"
    $('#template_form').prepend(ul)
    templateSlotCalendar.fullCalendar "unselect"
    $('#template_form').css('display', 'block')

  # TODO HZ: We have many forms here think about it.
  setFormFieldsValue: (event)->
    currentForm.setValues(event)

  successHandler: (event, data)->
    $('#template_form').html('')
    $('#template_form').html('<p class="success">Saved Successfully</p>')
    event = FormHandler.setEvent event, data
    unless event.isNew # refresh events if update
      templateSlotCalendar.fullCalendar 'rerenderEvents' 
    else
      event.isNew = false
      templateSlotCalendar.fullCalendar "renderEvent",
        title: data.id.toString()
        start: event.start
        recurring: data.recurring
        end: event.end
        id: data.id
        allDay: false
      , true # make the event "stick"
    $('#template_form').css('display', 'block')
    event

  sumitUpdateForm: (event)->
    $('#template_form').css('display', 'none')
    $('#template_form form').attr('action', $('#template_form form').attr('action') + "/#{event.id}")
    $('#template_form form').attr('method', 'patch')
    $('#template_form form').submit()

  showUpdateForm: (event)->
    FormHandler.showForm(event)
    $('#template_form form').attr('action', $('#template_form form').attr('action') + "/#{event.id}")
    $('#template_form form').attr('method', 'patch')

  showForm: (event, revertFunc=null)->
    $('#template_form').html(config.form)
    FormHandler.setFormFieldsValue(event)

    $('#template_form form').on 'submit', (e) ->
      e.preventDefault()
      url =$(@).attr('action') + '.json'
      data = $(@).serialize()
      if $('#template_form form').attr('method') == 'patch'
        data['_method'] = 'patch'
        type = 'patch'
      else
        type = 'POST'

      $.ajax
        type: type
        url: url
        data: data 
        dataType: 'json'

        success: (data)->
          FormHandler.successHandler event, data
          
        error: (xhr, textStatus, errorThrown) ->
          FormHandler.displayErros xhr.responseJSON.errors
          revertFunc() if revertFunc

@currentForm =
  setValues: (event)->
    if $('#new_template_slot')
      $('#template_slot_day').val(event.start.getDayName())
      $('#from_time_hour').val(("0" + event.start.getHours()).slice(-2))
      $('#from_time_minute').val(("0" + event.start.getMinutes()).slice(-2))
      $('#to_time_hour').val(("0" + event.end.getHours()).slice(-2))
      $('#to_time_minute').val(("0" + event.end.getMinutes()).slice(-2))
      $('#template_slot_recurring').val(event.recurring || 0)
    # else if $('#new_appointment')

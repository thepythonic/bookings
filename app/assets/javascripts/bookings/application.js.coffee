
#= require ./jquery/jquery
#= require ./jquery-ui/ui/jquery-ui
#= require ./jquery-ui/ui/jquery-ui-timepicker-addon
#= require ./full_calendar/fullcalendar
#= require ./moment

Date.prototype.getMonthName = ->
  m = ['January','February','March','April','May','June','July', 'August','September','October','November','December']
  m[@getMonth()]

Date.prototype.getDayName = ->
  d = ['Sunday','Monday','Tuesday','Wednesday', 'Thursday','Friday','Saturday']
  d[@getDay()]

@FormHandler =
  setEvent: (event, data)->
    event.recurring = data.recurring if data.time_slot
    event.customer_id = data.customer_id unless data.time_slot
    event.isTimeSlot = data.time_slot
    event.id = data.id if data.id
    event.title = data.id.toString() if data.id
    event.start = new Date(moment(data.start).format("MMM DD, YYYY HH:mm Z"))
    event.end =  new Date(moment(data.end).format("MMM DD, YYYY HH:mm Z"))
    event.allDay = false
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
    calendar.fullCalendar "unselect"
    $('#template_form').css('display', 'block')

  setFormFieldsValue: (event)->
    currentForm.setValues(event)

  successHandler: (event, data)->
    $('#template_form').html('')
    $('#template_form').html('<p class="success">Saved Successfully</p>')
    
    for k, values of data
      event = FormHandler.setEvent(event, values[0])
    
    unless event.isNew # refresh events if update
      calendar.fullCalendar 'rerenderEvents' 
    else
      event.isNew = false
      calendar.fullCalendar "renderEvent", event , false # make the event "stick"
    
    $('#template_form').css('display', 'block')
    calendar.fullCalendar "unselect"
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

  setDateTimePickerFields: ->
    if $('#new_time_slot').length
      from_field = 'time_slot_from_time'
      to_field = 'time_slot_to_time'
    else if $('#new_appointment').length
      from_field = 'appointment_from_time'
      to_field = 'appointment_to_time'

    $("##{from_field}").datetimepicker
      dateFormat: 'M d, yy',
      timeFormat: 'HH:mm Z'
      stepMinute: 15

    $("##{to_field}").datetimepicker
      dateFormat: 'M d, yy',
      timeFormat: 'HH:mm Z'
      stepMinute: 15

    $("##{from_field}").css('width', 300)
    $("##{to_field}").css('width', 300)


  showForm: (event, revertFunc=null)->
    $('#template_form').html(config.form)
    FormHandler.setFormFieldsValue(event)
    FormHandler.setDateTimePickerFields()

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
    if event.isTimeSlot
      $('#time_slot_from_time').val moment(event.start).format("MMM DD, YYYY HH:mm Z")
      $('#time_slot_to_time').val moment(event.end).format("MMM DD, YYYY HH:mm Z")
      $('#time_slot_recurring').val(event.recurring || 0)
    else 
      $('#appointment_from_time').val moment(event.start).format("MMM DD, YYYY HH:mm Z")
      $('#appointment_to_time').val moment(event.end).format("MMM DD, YYYY HH:mm Z")
      $('#appointment_customer_id').val event.customer_id
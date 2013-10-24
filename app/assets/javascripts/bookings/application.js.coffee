
#= require ./jquery/jquery
#= require ./jquery-ui/ui/jquery-ui
#= require ./full_calendar/fullcalendar

Date.prototype.getMonthName = ->
  m = ['January','February','March','April','May','June','July', 'August','September','October','November','December']
  m[@getMonth()]

Date.prototype.getDayName = ->
  d = ['Sunday','Monday','Tuesday','Wednesday', 'Thursday','Friday','Saturday']
  d[@getDay()]

FormHandler =
  setEvent: (event, data)->
    event.start.setHours(data.from_time.split(':')[0])
    event.start.setMinutes(data.from_time.split(':')[1])
    event.end.setHours(data.to_time.split(':')[0])
    event.end.setMinutes(data.to_time.split(':')[1])
    event.recurring = data.recurring
    event.id = data.id if data.id
    event

  displayErros: (errors)->
    ul = "<ul class='error'>"
    for key, value of errors
      ul += "<li>#{key}"
      li = "<ul>" + ["<li>#{v}</li>" for v in value].join() + "</ul>"
      ul += li + "</li>"
    ul += "</ul>"
    $('#template_form').prepend(ul)
    templateSlotCalendar.fullCalendar "unselect"
    $('#template_form').css('display', 'block')

  setFormFieldsValue: (event)->
    $('#template_slot_day').val(event.start.getDayName())
    $('#from_time_hour').val(event.start.getHours())
    $('#from_time_minute').val(event.start.getMinutes())
    $('#to_time_hour').val(event.end.getHours())
    $('#to_time_minute').val(event.end.getMinutes())
    $('#template_slot_recurring').val(event.recurring || 0)

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

  updateForm: (event)->
    $('#template_form').css('display', 'none')
    $('#template_form form').attr('action', $('#template_form form').attr('action') + "/#{event.id}")
    $('#template_form form').attr('method', 'patch')
    $('#template_form form').submit()

  showUpdatForm: (event)->
    FormHandler.showForm(event)
    $('#template_form form').attr('action', $('#template_form form').attr('action') + "/#{event.id}")
    $('#template_form form').attr('method', 'patch')

  showForm: (event)->
    $('#template_form').html(templateSlotForm)
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
          console.log event
        error: (xhr, textStatus, errorThrown) ->
          FormHandler.displayErros xhr.responseJSON.errors



$(document).ready ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  window.templateSlotCalendar = $("#calendar").fullCalendar
    eventClick: (event, element) ->
      FormHandler.showUpdatForm(event)
      

    theme: false
    slotMinutes: 15
    defaultView: 'agendaWeek'
    # columnFormat: 'dddd'  #display dayName without date
    allDay: false
    header:
      left: "prev,next today"
      center: "title"
      right: "agendaWeek"

    selectable: true
    selectHelper: true

    select: (start, end, allDay) ->
      FormHandler.showForm( {start: start, end: end, isNew: true} )
      
    editable: true

    events: (start, end, callback) ->
      $.ajax
        url: "/bookings/template/slots"
        dataType: 'json'
        success: (doc)->
          events = []
          for slot in doc.template_slots 
            events.push
              title: slot.title.toString()
              start: slot.start
              end: slot.end
              id: slot.id.toString()
              recurring: slot.recurring
              allDay: false
            
          callback(events)

    eventResize: (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view)->
      FormHandler.showForm(event)
      FormHandler.updateForm(event)
      
      
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, viw)->
      FormHandler.showForm(event)
      FormHandler.updateForm(event)
  
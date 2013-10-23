
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
  showForm: (id, start, end, recurrence=1)->
      $('#template_form').html(templateSlotForm)
      
      $('#template_slot_day').val(start.getDayName())
      $('#from_time_hour').val(start.getHours())
      $('#from_time_minute').val(start.getMinutes())
      $('#to_time_hour').val(end.getHours())
      $('#to_time_minute').val(end.getMinutes())

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
            $('#template_form').html('')
            $('#template_form').html('<p class="success">Saved Successfully</p>')
            start.setHours(data.from_time.split(':')[0])
            start.setMinutes(data.from_time.split(':')[1])
            end.setHours(data.to_time.split(':')[0])
            end.setMinutes(data.to_time.split(':')[1])

            tableSlotCalendar.fullCalendar "renderEvent",
              title: data.id.toString()
              start: start
              recurrence: data.recurrence
              end: end
              allDay: false
            , true # make the event "stick"
          error: (xhr, textStatus, errorThrown) ->
            ul = "<ul class='error'>"
            for key, value of xhr.responseJSON.errors
              ul += "<li>#{key}"
              li = "<ul>" + ["<li>#{v}</li>" for v in value].join() + "</ul>"
              ul += li + "</li>"
            ul += "</ul>"
            $('#template_form').prepend(ul)
            tableSlotCalendar.fullCalendar "unselect"



$(document).ready ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  window.tableSlotCalendar = $("#calendar").fullCalendar(
    eventClick: (event, element) ->
      FormHandler.showForm(event.title, event.start, event.end)
      $('#template_form form').attr('action', $('#template_form form').attr('action') + "/#{event.title}")
      $('#template_form form').attr('method', 'patch')

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
      FormHandler.showForm(null, start, end)
      

    editable: true
    events: "/bookings/template/slots"
  )

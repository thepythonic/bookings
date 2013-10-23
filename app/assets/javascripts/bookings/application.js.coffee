
#= require ./jquery/jquery
#= require ./jquery-ui/ui/jquery-ui
#= require ./full_calendar/fullcalendar

Date.prototype.getMonthName = ->
  m = ['January','February','March','April','May','June','July', 'August','September','October','November','December']
  m[@getMonth()]

Date.prototype.getDayName = ->
  d = ['Sunday','Monday','Tuesday','Wednesday', 'Thursday','Friday','Saturday']
  d[@getDay()]


$(document).ready ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  window.tableSlotCalendar = $("#calendar").fullCalendar(
    eventClick: (event, element) ->
      event.title = "CLICKED!"
      $("#calendar").fullCalendar "updateEvent", event

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
      $('#template_form').html(templateSlotForm);
      
      $('#template_slot_day').val(start.getDayName());
      $('#template_slot_from_time_4i').val(("0" + start.getHours()).slice(-2));
      $('#template_slot_from_time_5i').val(("0" + start.getMinutes()).slice(-2));
      $('#template_slot_to_time_4i').val(("0" + end.getHours()).slice(-2));
      $('#template_slot_to_time_5i').val(("0" + end.getMinutes()).slice(-2));
      
      $('#template_form form').on 'submit', (e) ->
        e.preventDefault()

        $.ajax
          type: "POST"
          url: $(@).attr('action') + '.json'
          data: $(@).serialize()
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

    editable: true
    events: "/bookings/template/slots"
  )

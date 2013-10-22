
#= require ./jquery/jquery
#= require ./jquery-ui/ui/jquery-ui
#= require ./full_calendar/fullcalendar

Date.prototype.getMonthName = ->
  m = ['January','February','March','April','May','June','July',
  'August','September','October','November','December']
  m[@getMonth()]

Date.prototype.getDayName = ->
  d = ['Sunday','Monday','Tuesday','Wednesday',
  'Thursday','Friday','Saturday']
  d[@getDay()]



$(document).ready ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  calendar = $("#calendar").fullCalendar(
    eventClick: (event, element) ->
      event.title = "CLICKED!"
      $("#calendar").fullCalendar "updateEvent", event

    theme: false
    slotMinutes: 15

    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    selectable: true
    selectHelper: true
    select: (start, end, allDay) ->
      $('#template_form').html(templateSlotForm);
      console.log start
      console.log end

      $('#template_slot_day').val(start.getDayName());
      $('#template_slot_from_time').val(start.getHours());
      $('#template_slot_to_time').val(end.getHours());

      # title = prompt("Event Title:")
      # if title
      #   calendar.fullCalendar "renderEvent",
      #     title: title
      #     start: start
      #     end: end
      #     allDay: allDay
      #   , true # make the event "stick"
      # calendar.fullCalendar "unselect"

    editable: true
    events: "/bookings/template/slots"
  )

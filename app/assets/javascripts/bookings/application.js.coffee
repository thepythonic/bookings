
#= require ./jquery/jquery
#= require ./jquery-ui/ui/jquery-ui
#= require ./full_calendar/fullcalendar

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

    header:
      left: "prev,next today"
      center: "title"
      right: "month,agendaWeek,agendaDay"

    selectable: true
    selectHelper: true
    select: (start, end, allDay) ->
      title = prompt("Event Title:")
      if title
        calendar.fullCalendar "renderEvent",
          title: title
          start: start
          end: end
          allDay: allDay
        , true # make the event "stick"
      calendar.fullCalendar "unselect"

    editable: true
    events: [
      title: "All Day Event"
      start: new Date(y, m, 1)
    ,
      title: "Long Event"
      start: new Date(y, m, d - 5)
      end: new Date(y, m, d - 2)
    ,
      id: 999
      title: "Repeating Event"
      start: new Date(y, m, d - 3, 16, 0)
      allDay: false
    ,
      id: 999
      title: "Repeating Event"
      start: new Date(y, m, d + 4, 16, 0)
      allDay: false
    ,
      title: "Meeting"
      start: new Date(y, m, d, 10, 30)
      allDay: false
    ,
      title: "Lunch"
      start: new Date(y, m, d, 12, 0)
      end: new Date(y, m, d, 14, 0)
      allDay: false
    ,
      title: "Birthday Party"
      start: new Date(y, m, d + 1, 19, 0)
      end: new Date(y, m, d + 1, 22, 30)
      allDay: false
    ,
      title: "Click for Google"
      start: new Date(y, m, 28)
      end: new Date(y, m, 29)
      url: "http://google.com/"
    ]
  )

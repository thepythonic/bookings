
$(document).ready ->
  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  window.templateSlotCalendar = $("#calendar").fullCalendar
    eventClick: (event, element) ->
      FormHandler.showUpdateForm(event)
      

    theme: false
    
    minTime: config.minTime || '0'
    maxTime: config.maxTime || '24'
    slotMinutes: 15
    allDaySlot: false
    defaultView: 'agendaWeek'
    columnFormat: 'dddd'  #display dayName without date
    allDay: false
    header:
      left: ""
      center: ""
      right: ""

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
      FormHandler.sumitUpdateForm(event)
      
      
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, viw)->
      FormHandler.showForm(event)
      FormHandler.sumitUpdateForm(event)
  
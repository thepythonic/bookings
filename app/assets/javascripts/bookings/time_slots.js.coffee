
$(document).ready ->
  
  @isTimeSlotView = true

  window.calendar = $("#calendar").fullCalendar
    theme: false
    minTime: config.minTime || '0'
    maxTime: config.maxTime || '24'
    slotMinutes: config.slotMinutes
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
    editable: true
    unselectAuto: false
    
    events: (start, end, callback) ->
      $.ajax
        url: "/bookings/time/slots"
        dataType: 'json'
        success: (doc)->
          events = []
          for slot in doc.time_slots 
            events.push
              title: slot.title.toString()
              start: slot.start
              end: slot.end
              id: slot.id.toString()
              recurring: slot.recurring
              allDay: false
          console.log events
          callback(events)  

    # click on event
    eventClick: (event, element) ->
      FormHandler.showUpdateForm(event)

    # resize event 
    eventResize: (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view)->
      FormHandler.showForm(event, revertFunc)
      FormHandler.sumitUpdateForm(event)    
    
    # drop and event  
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, viw)->
      FormHandler.showForm(event, revertFunc)
      FormHandler.sumitUpdateForm(event)
    
    # create new event
    select: (start, end, allDay) ->
      FormHandler.showForm( {start: start, end: end, isNew: true} )
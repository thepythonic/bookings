
$(document).ready ->

  window.calendar = $("#calendar").fullCalendar
    theme: false
    minTime: config.minTime || '0'
    maxTime: config.maxTime || '24'
    slotMinutes: config.slotMinutes
    allDaySlot: false
    defaultView: 'agendaDay'
    columnFormat: 'dddd'  #display dayName without date
    allDay: false
    slotEventOverlap: false

    header: 
        left: 'prev,next today'
        center: 'title'
        right: 'month,agendaWeek,agendaDay'

    selectable: true
    selectHelper: true
    editable: true
    unselectAuto: false
    
    events: (start, end, callback) ->
      $.ajax
        url: "/bookings/appointment/slots"
        dataType: 'json'
        success: (doc)->
          events = []
          for slot in doc.appointments
            events.push
              title: slot.title.toString()
              start: slot.start
              end: slot.end
              id: slot.id.toString()
              recurring: slot.recurring
              allDay: false
          
          console.log events

          callback(events)  

    eventAfterRender: (event, element, view)->
      element.css('left', 200) unless event.recurring
      element.css('width', 60 ) if view.name in ['agendaDay','agendaWeek'] and event.recurring

    # # click on event
    # eventClick: (event, element) ->
    #   FormHandler.showUpdateForm(event)

    # # resize event 
    # eventResize: (event, dayDelta, minuteDelta, revertFunc, jsEvent, ui, view)->
    #   FormHandler.showForm(event, revertFunc)
    #   FormHandler.sumitUpdateForm(event)    
    
    # # drop and event  
    # eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc, jsEvent, ui, viw)->
    #   FormHandler.showForm(event, revertFunc)
    #   FormHandler.sumitUpdateForm(event)
    
    # # create new event
    select: (start, end, allDay) ->
      FormHandler.showForm( {start: start, end: end, isNew: true} )
      $('#appointment_customer').autocomplete
        autoFocus: true 
        minLength: 3
        source: (request, response)->
          $.ajax
            url: '/bookings/customers'
            data: {term: request.term},
            dataType: "json",
            success: (data)->
              response $.map(data.customers, (item)-> 
                      label: item.customers.email
                      value: item.customers.id
                    )
        

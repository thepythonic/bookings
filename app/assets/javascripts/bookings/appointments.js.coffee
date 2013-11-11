
$(document).ready ->

  window.calendar = $("#calendar").fullCalendar
    theme: false
    minTime: config.minTime || '0'
    maxTime: config.maxTime || '24'
    slotMinutes: config.slotMinutes
    allDaySlot: false
    defaultView: 'agendaDay'
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
      current_view = $('#calendar').fullCalendar('getView')
      data = 
        start: moment(current_view.start).unix()
        mode: current_view.name

      $.ajax
        url: config.appointments_url
        data: data
        dataType: 'json'
        success: (doc)->
          events = []
          allAppointments = doc.appointments

          for slot in allAppointments
            events.push
              title: slot.title.toString()
              start: moment(slot.start).format("MMM DD, YYYY HH:mm Z")
              end: moment(slot.end).format("MMM DD, YYYY HH:mm Z")
              id: slot.id.toString()
              customer_id: slot.customer_id unless slot.time_slot
              recurring: slot.recurring
              isTimeSlot: slot.time_slot
              color: "#00ff00" if slot.time_slot
              allDay: false
              
          callback(events)  

    eventAfterRender: (event, element, view)->
      element.css('width', 60 ) if view.name in ['agendaDay','agendaWeek'] and event.isTimeSlot

    # # click on event
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
    
    # # create new event
    select: (start, end, allDay) ->
      FormHandler.showForm( {start: start, end: end, isNew: true} )
      $('#appointment_customer_id').autocomplete
        autoFocus: true 
        minLength: 3
        source: (request, response)->
          $.ajax
            url: '/bookings/customers/find'
            data: {term: request.term},
            dataType: "json",
            success: (data)->
              unless data.errors
                response $.map(data.customers, (item)-> 
                        label: item.customers.email
                        value: item.customers.id
                      )
              else
                FormHandler.displayErros data.errors
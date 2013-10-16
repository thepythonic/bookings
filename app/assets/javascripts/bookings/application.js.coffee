
#= require ./backbonejs/jquery
#= require ./backbonejs/underscore
#= require ./backbonejs/json2
#= require ./backbonejs/handlebars
#= require ./backbonejs/backbone
#= require ./backbonejs/backbone.babysitter
#= require ./backbonejs/backbone.wreqr
#= require ./backbonejs/backbone.marionette
#= require ./foundation.min
#= require ./foundation-datepicker
#= require ./moment
#= require ./moment-twix

#= require ./app

#= require ./models/appointment
#= require ./models/employee
#= require ./models/customer
#= require ./collections/appointments
#= require ./collections/employees
#= require ./collections/customers
#= require ./views/appointment
#= require ./routers/appointment

# CALENDAR

#= require ./calendar/week/week_view
#= require ./calendar/models/calendar
#= require ./calendar/collections/calendars
#= require ./calendar/calendar_app
# = require ./calendar/views/calendar


$(document).foundation()

Backbone.Marionette.TemplateCache.prototype.compileTemplate = (rawTemplate) -> 
      Handlebars.compile(rawTemplate);
      
  
# window.Calendar = new Backbone.Marionette.Application()
# appointmentList = new AppointmentList()
# employeeList = new EmployeeList()
# customerList = new CustomerList()
# viewOptions = 
#   collection: appointmentList
#   employees: employeeList
#   customers: customerList

# appointmentView = new AppointmentDayView(viewOptions)

# Calendar.addRegions
#   mainRegion: "#content"
#   calendar: "#calendar"

# Calendar.on 'start', ->
#   Backbone.history.start()

# Calendar.addInitializer ->
#   Calendar.mainRegion.show(appointmentView)
#   appointmentList.fetch()
#   employeeList.fetch()
#   customerList.fetch()
#   c = new CalendarLayout()
#   Calendar.calendar.show(c)
#   c.header.show(new CalendarWeekHeaderView(model: new CalendarDate()))
  
  
# Calendar.listenTo appointmentList, 'all', ->
#   Calendar.mainRegion.$el.toggle(appointmentList.length > 0)





$(document).ready ->
  Bookings.start()
  Bookings.startSubApp('CalendarApp')

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


#= require ./models/appointment
#= require ./models/employee
#= require ./models/customer
#= require ./collections/appointments
#= require ./collections/employees
#= require ./collections/customers
#= require ./views/appointment
#= require ./routers/appointment

$(document).foundation()

Backbone.Marionette.TemplateCache.prototype.compileTemplate = (rawTemplate) -> 
      Handlebars.compile(rawTemplate);
      
  
window.Calendar = new Backbone.Marionette.Application()
appointmentList = new AppointmentList()
employeeList = new EmployeeList()
customerList = new CustomerList()
viewOptions = 
  collection: appointmentList
  employees: employeeList
  customers: customerList

appointmentView = new AppointmentDayView(viewOptions)

Calendar.addRegions
  mainRegion: "#content"

Calendar.on 'start', ->
  Backbone.history.start()

Calendar.addInitializer ->
  Calendar.mainRegion.show(appointmentView)
  appointmentList.fetch()
  employeeList.fetch()
  customerList.fetch()


Calendar.listenTo appointmentList, 'all', ->
  Calendar.mainRegion.$el.toggle(appointmentList.length > 0)

$(document).ready ->
  # Calendar.start()

#= require ./backbonejs/jquery
#= require ./backbonejs/underscore
#= require ./backbonejs/json2
#= require ./backbonejs/handlebars
#= require ./backbonejs/backbone
#= require ./backbonejs/backbone.babysitter
#= require ./backbonejs/backbone.wreqr
#= require ./backbonejs/backbone.marionette
#= require ./foundation.min


#= require ./models/appointment
#= require ./collections/appointments
#= require ./views/appointment
#= require ./routers/appointment

$(document).foundation()

Backbone.Marionette.TemplateCache.prototype.compileTemplate = (rawTemplate) -> 
      Handlebars.compile(rawTemplate);
      
  
window.Calendar = new Backbone.Marionette.Application()
appointmentList = new AppointmentList()
viewOptions = collection: appointmentList

appointmentView = new AppointmentDayView(viewOptions)

Calendar.addRegions
  mainRegion: "#content"

Calendar.on 'start', ->
  Backbone.history.start()

Calendar.addInitializer ->
  console.log("AAAAAAAAAAA")
  console.log(Calendar.mainRegion)
  Calendar.mainRegion.show(appointmentView)
  appointmentList.fetch()

$(document).ready ->
  Calendar.start()
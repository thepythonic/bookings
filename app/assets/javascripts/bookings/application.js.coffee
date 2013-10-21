
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
#= require ./collections/employees
#= require ./collections/customers
#= require ./views/appointment
#= require ./routers/appointment

# CALENDAR
#= require ./calendar/models/calendars
#= require ./calendar/calendar_app
#= require ./calendar/calendar_base_views
#= require ./calendar/calendar_switcher
#= require ./calendar/calendar_week_views
#= require ./calendar/calendar_month_views

Handlebars.registerHelper "debug", (optionalValue) ->
  console.log("Current Context")
  console.log("====================")
  console.log(@)
 
  if (optionalValue)
    console.log("Value")
    console.log("====================")
    console.log(optionalValue)

$(document).foundation()

Backbone.Marionette.TemplateCache.prototype.compileTemplate = (rawTemplate) -> 
      Handlebars.compile(rawTemplate);
      

$(document).ready ->
  Bookings.start()

 
class @Router extends Backbone.Marionette.AppRouter
  appRoutes: 
    "": "list_appointments"
    "appointment/:id": "show_appointment"
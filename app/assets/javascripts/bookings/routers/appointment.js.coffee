@Router = Backbone.Marionette.AppRouter.extend
  appRoutes: 
    "": "list_appointments"
    "appointment/:id": "show_appointment"
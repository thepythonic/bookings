@Bookings = (
  (Backbone, Marionette) ->
    "use strict"

    App = new Marionette.Application()

    App.addRegions
      mainRegion: "#content"
      calendar: "#calendar"

    App.on "initialize:after", ->
      if (Backbone.history)
        Backbone.history.start()

    App.startSubApp = (appName, args) ->
      currentApp = App.module appName

      if App.currentApp == currentApp
        return;

      App.currentApp.stop() if App.currentApp
        
      App.currentApp = currentApp
      currentApp.start args 
    
    App.addInitializer = ->
      App.trigger("calendar:init")


    App
)(Backbone, Marionette)

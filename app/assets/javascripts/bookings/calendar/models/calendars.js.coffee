@Bookings.module "CalendarApp.Models", (Models, Bookings, Backbone, Marionette, $, _)->

  class Models.CalendarDate extends Backbone.Model
    defaults:
      date: moment().format 'MMM D, YYYY'
      mode: 'week'
      outOfRange: false
    
    month_formatted: ->
      (moment @get 'date').format 'MMM'
    
    range_formatted: ->
      (moment @get 'date').startOf('week').format('D') + ' - ' + (moment @get 'date').format('D')
    
    year_formatted: ->
      (moment @get 'date').format 'YYYY'

    date_formatted: ->
      if @get('mode') == 'week'
        "<strong>" + @month_formatted() + ' ' + @range_formatted() + ",</strong> "+ @year_formatted()
      else
        "<strong>" + (moment @get 'date').format 'MMMM'  + "</strong>" 

   
    date_formatted_day: ->
      (moment @get 'date').format 'dddd, D MMM'

    day_formatted: ->
      (moment @get 'date').format 'D'

    outOfRange: ->
      @get 'outOfRange'

    mode: ->
      @get 'mode'

    toJSON: ->
      data = _.clone @attributes ;
      data.date_formatted = @date_formatted()
      data.month_formatted = @month_formatted()
      data.range_formatted = @range_formatted()
      data.year_formatted = @year_formatted()
      data.date_formatted_day = @date_formatted_day()
      data.mode =  @mode()
      data.outOfRange =  @outOfRange()
      data

  class Models.CalendarDateList extends Backbone.Collection
    model: Models.CalendarDate

  API =
    getCalendatDateListForRange: (days_range)->
      collection = []
      while days_range.hasNext()
        collection.push new Models.CalendarDate date: days_range.next()

      new Models.CalendarDateList(collection)

    getCalendatDateListForMonthRange: (days_range, month)->
      week = []
      collection = []
      i = 1

      while days_range.hasNext()
        date = days_range.next()
        if date.month().toString() == month.toString()
          outOfRange = false
        else
          outOfRange = true

        calendateDate =  new Models.CalendarDate 
          date: date
          mode: "month"
          outOfRange: outOfRange
        
        week.push calendateDate

        if (i % 7) == 0
          collection.push new Models.CalendarDateList week
          week = []

        i++
      
      new Models.CalendarDateList collection
      

  Bookings.reqres.setHandler 'calendar:datelist:range', (days_range)->
    API.getCalendatDateListForRange days_range

  Bookings.reqres.setHandler 'calendar:datelist:month:range', (days_range, month)->
    API.getCalendatDateListForMonthRange days_range, month
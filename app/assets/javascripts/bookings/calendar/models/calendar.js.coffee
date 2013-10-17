class @CalendarDate extends Backbone.Model
  defaults:
    date: moment().format('MMM D, YYYY')
  
  date_formatted: ->
    moment(@get('date')).format('MMM D, YYYY')

  date_formatted_day: ->
    moment(@get('date')).format('dddd, D MMM')

  toJSON: ->
    data = _(@attributes).clone();
    data.date_formatted = @date_formatted()
    data.date_formatted_day = @date_formatted_day()
    data
class @CalendarDate extends Backbone.Model
  defaults:
    date: moment().format('MMM D, YYYY')
  
  date_formatted: ->
    moment(@get('date')).format('MMM D, YYYY')

  toJSON: ->
    data = _(@attributes).clone();
    data.date_formatted = @date_formatted()
    data
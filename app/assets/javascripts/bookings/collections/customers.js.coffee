@CustomerList = Backbone.Collection.extend
  model: Customer
  url: '/patients.json'
  